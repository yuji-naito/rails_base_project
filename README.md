## プロジェクトの概要
初期画面が表示するだけのベースプロジェクト。
ここから各必要に応じて機能を追加していくことが可能。
本プロジェクトはビューを使用する通常のRailsプロジェクト

## システム情報
Ruby: 3.0.2
Rails: 6.1.4
PostgreSQL: 13.3

## コマンド説明
```bash
# コンテナ起動
make up

# コンテナ終了
make down

# コンテナ再起動
make restart
```

## プロジェクトセットアップ
```bash
# GitHubからプロジェクトをダウンロード
git clone git@github.com:yuji-naito/rails_base_project.git

# プロジェクトをビルド
make init
```