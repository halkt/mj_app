# ユーザーを作成する
User.create!(name:  "サンプルくん",
             mail: "sample@example.com",
             admin: true,
             password:              "simple@sample",
             password_confirmation: "simple@sample")

19.times do |i|
  i += 1
  # ユーザーを作成する
  User.create(
    name: "テストユーザー#{i}",
    mail: "user#{i}@example.com",
    admin: false,
    password:              "password",
    password_confirmation: "password"
  )
end

# ウマを作成する
Horse.create(name: "無し", point1: 0, point2: 0)
Horse.create(name: "5-10", point1: 5000, point2: 10000)
Horse.create(name: "10-20", point1: 10000, point2: 20000)

# イベントを作成する
5.times do |i|
  i += 1
  Event.create(
    name: "麻雀大会#{i}",
    day: "2019-04-01"
  )
  # イベント
  EventUser.create(user_id: i, event_id: 1)
  EventUser.create(user_id: i, event_id: 2)
  EventUser.create(user_id: i, event_id: 3)
  EventUser.create(user_id: i, event_id: 4)
  EventUser.create(user_id: i, event_id: 5)
end

# ゲームを作成する
10.times do |i|
  i += 1
  5.times do |j|
    j += 1
    Game.create(event_id: j,
                genten: 25000,
                kaeshiten: 30000,
                horse_id: 1
                )
  end
end

# ゲーム詳細
5.times do |i|
  i += 1
  GameDetail.create(game_id: i,
                    user_id: 1,
                    point: 40000,
                    rank: 1
                    )
  GameDetail.create(game_id: i,
                    user_id: 2,
                    point: 30000,
                    rank: 2
                    )
  GameDetail.create(game_id: i,
                    user_id: 3,
                    point: 20000,
                    rank: 3
                    )
  GameDetail.create(game_id: i,
                    user_id: 4,
                    point: 10000,
                    rank: 4
                    )
end
