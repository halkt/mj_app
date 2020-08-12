# MJ-NOTE
![Rspec](https://github.com/halkt/mj_app/workflows/Ruby/badge.svg)
「MJ-NOTE」は、麻雀の成績を自動計算＆管理できるRails APIアプリケーションです。
簡単なルールと対局終了の点数を入力することで、自動的にスコアが計算されて登録されます。
また、過去の成績を照会することや、自分の成績を確認することができます。
※スマートフォンからの利用も可能なよう、レスポンシブデザインを採用しています。

## 環境構築
### リポジトリをclone
本リポジトリをcloneする

### コンテナの生成
10分ほどかかります
```
docker-compose up -d --build
```

### DBの作成
```
docker-compose run --rm app db:create
docker-compose run --rm app db:migrate
docker-compose run --rm app db:seed
```

### アクセス
http://localhost/
