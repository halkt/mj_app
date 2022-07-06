# frozen_string_literal: true

def main
  ActiveRecord::Base.transaction do
    create_master_data
    create_transaction_data
  end
end

def create_master_data
  create_admin_user
  5.times do |index|
    create_normal_user(index + 1)
  end
  create_horses
  create_communities
  User.all.each do |user|
    create_community_user(default_community.id, user.id)
  end
  create_event
end

def create_transaction_data
  event = default_event
  User.all.each do |user|
    create_event_user(user.id, event.id)
  end
  5.times do
    create_game(event.id)
  end
end

def create_admin_user
  User.create(
    name: 'サンプルくん',
    mail: 'sample@example.com',
    admin: true,
    login_flg: true,
    password: 'simple@sample',
    password_confirmation: 'simple@sample'
  )
end

def create_normal_user(index)
  default_password = 'password'
  User.create(
    name: "テストユーザー#{index}",
    mail: "user#{index}@example.com",
    admin: false,
    login_flg: false,
    password: default_password,
    password_confirmation: default_password
  )
end

def create_horses
  Horse.create(name: '無し', point1: 0, point2: 0)
  Horse.create(name: '5-10', point1: 10_000, point2: 5_000)
  Horse.create(name: '10-20', point1: 20_000, point2: 10_000)
end

def create_communities
  Community.create(name: '麻雀部')
  Community.create(name: 'N会')
  Community.create(name: 'テスト')
end

def create_community_user(community_id, user_id)
  CommunityUser.create(community_id: community_id, user_id: user_id)
end

def create_event
  Event.create(
    name: '麻雀大会',
    day: '2019-04-01',
    community: default_community
  )
end

def create_event_user(user_id, event_id)
  EventUser.create(user_id: user_id, event_id: event_id)
end

def create_game(event_id)
  game = Game.new(
    event_id: event_id,
    genten: 25_000,
    kaeshiten: 30_000,
    horse_id: 1,
    game_detail: game_details
  )
  game.save
end

def game_details
  first_detail = GameDetail.new(user_id: 1, point: 40_000, rank: 1, score: 30.0)
  second_detail = GameDetail.new(user_id: 2, point: 30_000, rank: 2, score: 0.0)
  third_detail = GameDetail.new(user_id: 3, point: 20_000, rank: 3, score: -10.0)
  forth_detail = GameDetail.new(user_id: 4, point: 10_000, rank: 4, score: -20.0)
  [first_detail, second_detail, third_detail, forth_detail]
end

def default_community
  Community.find_by(name: 'テスト')
end

def default_event
  Event.find_by(name: '麻雀大会')
end

main
