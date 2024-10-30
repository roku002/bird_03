# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
* このアプリケーションはRuby 3.2.2で動作します。

* System dependencies
  - Ruby 3.2.2
  - Rails 7.0.8
  - PostgreSQL 17
  - Node.js 19
  - Yarn

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Rubocopテスト
* $ docker compose exec web bundle exec rubocop -a

* Rspecテスト
* コンテナ内で $ bundle exec rspec

# サービス名
## Buncho-Lover

**サービス概要**

文鳥好きによる文鳥好きの為のアプリ

**このサービスへの思い・作りたい理由**

以前文鳥を飼っていたので、同じ文鳥好き同士が集まれるアプリがあればと思いました。

**ユーザー層について**

小鳥を飼うのは決めているが、小鳥の種類を迷っている方
文鳥を飼っている方
文鳥が好きな方
文鳥について質問がある方
小鳥が好きな方

**サービスの利用イメージ**

文鳥の魅力を伝えたり、同じ文鳥を飼っている人同士で
情報交換やコミュニティが取れる場所にしていきたい

**ユーザーの獲得について**

自分のXで宣伝します。

**サービスの差別化ポイント・推しポイント**

調べたとこと、犬や猫のアプリは多かったが
文鳥をメインにしているアプリはありませんでした
昔飼っていたこともあり、文鳥をあまり知らない人にも文鳥の
魅力を知ってもらえるアプリにしていきたい

**機能候補**
1. MVP
 - ログイン
 - 新規登録
 - マイページ
 - 投稿機能(画像・タイトル・本文・タグ・投稿日・)
 - 投稿一覧画面
 - 投稿詳細画面
 - パスワード再設定機能
 - いいね機能
 - 文鳥の魅力を書く
 - タグ機能
1. 本リリース
 - 静的OGP
 - minimagick導入
 - 掲示板作成
 - コメント機能(turbo_stream)
 - チャット機能(Action_cable)
 - ソーシャルログイン(Google)
 - GitHubActions(Rubocop,Rspec)
 - AWSのS3外部ストレージを利用して本番環境の画像を置く

**機能の実装方針予定**
- AIを利用した機能