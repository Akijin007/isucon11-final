# isucon11-finalの練習用リポジトリ

## Build and deploy

repo 直下の `Makefile` から、手元でのビルド・テストとAnsibleデプロイ、ベンチマーク起動を行います。

```sh
# ansible/inventory.yaml に接続aliasとapp設定を記入（SSHの秘密情報は ~/.ssh/config で管理）
make test
make deploy-check
make deploy
make bench
# または make deploy-bench
```

`make test` は手元のGoで実行します。`make deploy` はソースをアプリサーバーへ転送し、
inventoryで指定したサーバー上のGoでビルドしてsystemdサービスを再起動します。
これでデプロイ用バイナリのOS・CPU・Goツールチェーンはサーバー側に揃い、手元では
開発中のテストを続けられます。`go/go.mod` はGo 1.17を指定しています。手元も対象サーバーと
同じGoで確認したい場合は、`GO=/path/to/go make test` のようにGoバイナリを指定できます。
`make bench` はbenchmarker上で`./bin/benchmarker -target 172.31.1.99:443 -tls -exit-status`を実行します。
この呼び出し方は[issue #1](https://github.com/Akijin007/isucon11-final/issues/1)に合わせています。
