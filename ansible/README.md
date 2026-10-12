# Deployment files

- `inventory.yaml` is the inventory used by the root `Makefile`. It uses the app and benchmarker aliases `isucon11-app` and
  `isucon11-bench`, the `isucholar.go.service` unit, and the running binary path
  `/home/isucon/webapp/go/isucholar`. The server Go binary is
  `/home/isucon/local/go/bin/go` (Go 1.17.1).
- `~/.ssh/config` supplies the Tailscale destinations and identity files. Keep those
  private values out of this repo.
- `deploy.yaml` copies the Go sources, builds them with `app_go_binary` on the app
  server, and restarts the configured systemd service when the binary changes.
- `bench.yaml` runs this command on the `benchmarker` host, using the settings in
  the local inventory:

  ```sh
  ./bin/benchmarker -target 172.31.1.99:443 -tls -exit-status
  ```

  The command and target are from [issue #1](https://github.com/Akijin007/isucon11-final/issues/1).

The benchmark command should target the app over the benchmark network's intended
route. SSH management traffic uses the aliases from `~/.ssh/config`.
