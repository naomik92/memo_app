# memo_app
## 概要
シンプルなメモアプリです。
## 使用技術
- Ruby 3.3.6
- Sinatra 4.1.1
## データベースの準備
1. PostgreSQLを自分のマシンにインストールします。
2. PostgreSQLにログインします
3. データベースを作成（データベース名：memo_app）
```
CREATE DATABASE memo_app;
```
4. テーブルを作成（テーブル名：memo_data）
```
CREATE TABLE memo_data
  (id VARCHAR(50) NOT NULL,
  title VARCHAR(100),
  detail VARCHAR(1000),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id);)
```
## インストール方法
以下の手順でプロジェクトをローカル環境にインストールします。
1. `$ git clone`リポジトリをクローンします
2. `$ cd memo_app`ディレクトリへ移動します
3. `$ bundle install`でインストールします
## 使い方
1. `$ bundle exec ruby app.jp`アプリケーションを立ち上げます
2. [http://localhost:4567/memos](http://localhost:4567/memos)へアクセスすると、ローカル環境でメモアプリが使用できるようになります

このリポジトリは、FjordBootCampのプラクティス「Sinatraを使ってWebアプリケーションの基本を理解する」で作成しました。
