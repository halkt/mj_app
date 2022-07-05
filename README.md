![Rspec](https://github.com/halkt/mj_app/workflows/Ruby/badge.svg)

# MJ-NOTE

## Overview

- 麻雀の成績管理をするRailsアプリケーションです
- 対局終了時の点数を入力することで、スコア計算されて登録されます
- 過去の成績を照会、自分の成績を確認することができます

## Setup

### 1. clone

```bash
git clone git@github.com:halkt/mj_app.git
```

### 2. build

```bash
docker-compose up -d --build
```

### 3. db migrate

```bash
docker-compose run --rm app db:create
docker-compose run --rm app db:migrate
docker-compose run --rm app db:seed
```

## Memo

### rspec

```bash
docker-compose run --rm app rspec
```

### rubocop

```bash
docker-compose run --rm app rubocop ${file_name}
```
