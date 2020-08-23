# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { 'テスト大会1' }
    day { '2019-03-23' }
    description { 'テストです' }
    association :community
    with_default_users

    trait :with_default_users do
      after(:build) do |event|
        event.users << FactoryBot.build(:user, name: 'one')
        event.users << FactoryBot.build(:user, name: 'two')
        event.users << FactoryBot.build(:user, name: 'three')
        event.users << FactoryBot.build(:user, name: 'four')
      end
    end
  end
end
