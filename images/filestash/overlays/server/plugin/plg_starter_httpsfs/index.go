package plg_starter_httpsfs

import (
	"context"
	"crypto/tls"
	"fmt"
	"net/http"
	"time"

	. "github.com/mickael-kerjean/filestash/server/common"

	"github.com/gorilla/mux"
)

func init() {
	Hooks.Register.Starter(func(ctx context.Context, r *mux.Router) {
		port := Config.Get("general.port").Int()
		certFile := GetAbsolutePath(CERT_PATH, "cert.pem")
		keyFile := GetAbsolutePath(CERT_PATH, "key.pem")
		Log.Info("[httpsfs] starting with certs from %s", GetAbsolutePath(CERT_PATH))

		srv := &http.Server{
			Addr:         fmt.Sprintf(":%d", port),
			Handler:      r,
			TLSNextProto: make(map[string]func(*http.Server, *tls.Conn, http.Handler), 0),
			TLSConfig:    &DefaultTLSConfig,
			ErrorLog:     NewNilLogger(),
		}

		go func() {
			ensureAppHasBooted(
				fmt.Sprintf("https://127.0.0.1:%d/about", port),
				fmt.Sprintf("[httpsfs] listening on :%d", port),
			)
			<-ctx.Done()
			srv.Shutdown(context.Background())
		}()
		if err := srv.ListenAndServeTLS(certFile, keyFile); err != nil && err != http.ErrServerClosed {
			Log.Error("[httpsfs] listen_serve %v", err)
			return
		}
	})
}

func ensureAppHasBooted(address string, message string) {
	for i := 0; i < 10; i++ {
		time.Sleep(250 * time.Millisecond)
		res, err := HTTPClient.Get(address)
		if err != nil {
			continue
		}
		res.Body.Close()
		if res.StatusCode != http.StatusOK && res.StatusCode != http.StatusNotFound {
			continue
		}
		Log.Info(message)
		break
	}
}
