import type { BetterAuthPlugin } from "better-auth";
import { createSessionEndpoint } from "./endpoints/session";

/**
 * better-auth plugin for reverse-proxy authentication (Authelia, Authentik, etc.).
 *
 * When a trusted reverse proxy has already authenticated the user it
 * forwards identity via headers:
 *   - Remote-User     (required — username)
 *   - Remote-Email    (optional — email address)
 *   - Remote-Name     (optional — display name)
 *   - Remote-Groups   (optional — comma-separated groups)
 *
 * This plugin exposes a single endpoint: POST /proxy-auth/session
 * which the API middleware calls internally when it detects
 * Remote-User on an incoming request.  The endpoint:
 *   1. Looks up the user by their proxy username.
 *   2. Auto-provisions them if they don't exist yet.
 *   3. Creates a better-auth session and returns it.
 *
 * No schema extensions are needed — we reuse the `username` field
 * added by the username-only plugin (both plugins coexist).
 */
const proxyAuth = (): BetterAuthPlugin => {
  return {
    id: "proxy-auth",
    endpoints: {
      proxyAuthSession: createSessionEndpoint(),
    },
  };
};

export { proxyAuth };
