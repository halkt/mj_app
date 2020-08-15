# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    genten { 25_000 }
    kaeshiten { 30_000 }
    description { 'hogehoge' }
    association :event
    association :horse
    with_default_details

    trait :with_default_details do
      after(:build) do |game|
        game.game_detail << FactoryBot.build(:game_detail, point: 30_000)
        game.game_detail << FactoryBot.build(:game_detail, point: 26_000)
        game.game_detail << FactoryBot.build(:game_detail, point: 24_000)
        game.game_detail << FactoryBot.build(:game_detail, point: 20_000)
      end
    end

    to_create { |instance| instance.save(validate: false) }
  end
end
