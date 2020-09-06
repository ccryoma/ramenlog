# 概要
ラーメン店の検索、およびレビューを共有できるサービスです。

## URL

## 使用技術一覧
### インフラ
* AWS( EC2, RDS, Route53, VPC, S3, EIP )
### DB
* MySQL2
### バックエンド
* Ruby 2.6.3
* Rails 6.0.3
### フロントエンド
* JavaScript
* jQuery
* HTML, SCSS
* Bootstrap
### 開発環境
* VSCode
* Docker, Docker-compose
* Rubocop
### 本番環境
* Nginx
* Unicorn
### テスト
* RSpec, Capybara, Faker, FactoryBot
### デプロイ
* Capistrano3
### その他
* Google Maps API
* jQuery.raty
* jQuery validation

## クラウドアーキテクチャ
![architecture](https://user-images.githubusercontent.com/67304331/92231189-50e0fe80-eee7-11ea-8de9-2933be8875cf.png)

## E-R図
![E-R Diagram](https://user-images.githubusercontent.com/67304331/92330687-b7167e80-f0ab-11ea-9266-c482bff8f029.png)


## 機能一覧
* 会員登録機能
* パスワード再設定機能
* リメンバーミー
* ログイン情報のセッション保持
* プロフィール編集機能(テストユーザーは利用不可)
* フォーム入力時点のバリデーションチェック
* 会員一覧表示機能
* メール配信機能
* 店舗登録機能
* 店舗に対するレビュー投稿機能
* 複数画像投稿機能(枚数制限)
* 店舗検索機能(一覧表示/地図表示)
* タグ検索機能
* 管理者ログイン機能
* テストログイン機能(お試し利用)
* パンくずリスト
* ページネーション
* トランザクション制御機能

