FactoryBot.define do
  factory :event do
    name { 'テスト大会1' }
    day { '2019-03-23'}
    description { 'テストです'}
    user
  end
end
