# Ansibleの設定

- `inventory.yaml` はリポジトリ直下の `Makefile` から使うインベントリです。アプリケーションサーバーとベンチマーカーには、それぞれ `isucon11-app` と `isucon11-bench` というSSHエイリアスを使います。systemdのサービス名は `isucholar.go.service`、実行中のバイナリは `/home/isucon/webapp/go/isucholar` です。サーバー上のGoは `/home/isucon/local/go/bin/go`（Go 1.17.1）を使います。
- Tailscaleの接続先と認証情報は `~/.ssh/config` で設定します。秘密情報をこのリポジトリに含めないでください。
- `deploy.yaml` はGoのソースをアプリケーションサーバーにコピーし、`app_go_binary` でビルドします。バイナリが更新された場合は、設定されたsystemdサービスを再起動します。
- `bench.yaml` はローカルのインベントリ設定を使い、ベンチマーカー上で次のコマンドを実行します。

  ```sh
  ./bin/benchmarker -target 172.31.1.99:443 -tls -exit-status
  ```

  コマンドと接続先は[Issue #1](https://github.com/Akijin007/isucon11-final/issues/1)に基づいています。
- `make bench` は実行ごとに一意なログファイルをリポジトリの `logs/` に保存します。ファイル名は `bench_<UTC日時>_<一意な識別子>.log` です。ログには実行ID、Git commit、接続先、開始時刻、ベンチマーカー名、標準出力と標準エラー、最後に `benchmark_exit_code` が記録されます。ベンチマークが失敗した場合も、ログをローカルに回収してから失敗を報告します。

ベンチマークは、ベンチマーク用ネットワークで想定されている経路を通じてアプリケーションサーバーに接続してください。SSH管理接続には `~/.ssh/config` のエイリアスを使います。
