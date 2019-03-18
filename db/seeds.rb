# adminユーザーを作成する
User.create!(name:  "admin",
             mail: "admin@example.com",
             admin: true,
             password:              "password",
             password_confirmation: "password")

# ウマを作成する
Horse.create(name: "無し", point1: 0, point2: 0)
Horse.create(name: "5-10", point1: 5000, point2: 10000)
Horse.create(name: "10-20", point1: 10000, point2: 20000)

5.times do |i|
  i += 1
  # ユーザーを作成する
  User.create(
    name: "テストユーザー#{i}",
    mail: "user#{i}@example.com",
    admin: false,
    password:              "password",
    password_confirmation: "password"
  )

  # イベントを作成する
  Event.create(
    name: "テスト大会#{i}"
  )
  # ゲームを作成する
  Game.create(event_id: 1,
              genten: 25000,
              kaeshiten: 30000,
              horse_id: 1
              )

end

# イベントにユーザーを紐付ける
EventUser.create(user_id: 2, event_id: 1)
EventUser.create(user_id: 3, event_id: 1)
EventUser.create(user_id: 4, event_id: 1)
EventUser.create(user_id: 5, event_id: 1)
EventUser.create(user_id: 6, event_id: 1)

5.times do |j|
  # ゲーム詳細
  GameDetail.create(game_id: j,
                    user_id: 2,
                    point: 40000,
                    rank: 1
                    )
  GameDetail.create(game_id: j,
                    user_id: 3,
                    point: 30000,
                    rank: 2
                    )
  GameDetail.create(game_id: j,
                    user_id: 4,
                    point: 20000,
                    rank: 3
                    )
  GameDetail.create(game_id: j,
                    user_id: 5,
                    point: 10000,
                    rank: 4
                    )
end
