5.times do |i|
  i += 1
  User.create(
    name: "テストユーザー#{i}",
    mail: "user#{i}@example.com"
  )

  Event.create(
    name: "テスト大会#{i}"
  )
end

EventUser.create(user_id: 1, event_id: 1)
EventUser.create(user_id: 1, event_id: 2)
EventUser.create(user_id: 1, event_id: 3)
EventUser.create(user_id: 2, event_id: 1)
EventUser.create(user_id: 2, event_id: 2)
