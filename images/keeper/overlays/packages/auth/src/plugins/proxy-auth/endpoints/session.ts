import { createAuthEndpoint } from "better-auth/api";
import { z } from "zod";

interface ProxyUser {
  id: string;
  username: string;
  name: string;
  email: string;
  emailVerified: boolean;
  createdAt: Date;
  updatedAt: Date;
}

/**
 * POST /api/auth/proxy-auth/session
 *
 * Called internally by the API middleware when `Remote-User` is present.
 * The middleware passes the header values in the JSON body — this
 * endpoint never reads headers directly (the proxy headers are on the
 * outer request, not on the internal fetch to better-auth).
 *
 * Flow:
 *   1. Find user by username.
 *   2. If not found, auto-provision with the proxy-provided identity.
 *   3. Create a session and set the session cookie.
 */
const createSessionEndpoint = () =>
  createAuthEndpoint(
    "/proxy-auth/session",
    {
      body: z.object({
        username: z.string().min(1),
        email: z.string().email().optional(),
        name: z.string().optional(),
      }),
      method: "POST",
    },
    async (context) => {
      const { username, email, name } = context.body;

      // Look up existing user by username.
      let user = await context.context.adapter.findOne<ProxyUser>({
        model: "user",
        where: [{ field: "username", value: username }],
      });

      if (!user) {
        // Also try by email if the proxy provided one — the user may
        // have been created via another auth method.
        if (email) {
          user = await context.context.adapter.findOne<ProxyUser>({
            model: "user",
            where: [{ field: "email", value: email }],
          });
        }
      }

      if (!user) {
        // Auto-provision the user.  No password is set — they can
        // only authenticate via the reverse proxy.
        const syntheticEmail = email ?? `${username}@proxy.local`;
        user = await context.context.adapter.create<ProxyUser>({
          data: {
            createdAt: new Date(),
            email: syntheticEmail,
            emailVerified: true,
            name: name ?? username,
            updatedAt: new Date(),
            username,
          },
          model: "user",
        });

        // Create an account record tied to the "proxy" provider so
        // the user shows up in account listings.
        await context.context.adapter.create({
          data: {
            accountId: user.id,
            createdAt: new Date(),
            providerId: "proxy",
            updatedAt: new Date(),
            userId: user.id,
          },
          model: "account",
        });
      }

      // Create a session.
      const session = await context.context.internalAdapter.createSession(
        user.id,
        false,
      );

      // Set the session cookie so subsequent requests are authenticated
      // without needing the proxy headers (useful for WebSocket
      // connections and API calls from the frontend JS).
      await context.setSignedCookie(
        context.context.authCookies.sessionToken.name,
        session.token,
        context.context.secret,
        context.context.authCookies.sessionToken.attributes,
      );

      return context.json({ session, user });
    },
  );

export { createSessionEndpoint };
