FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    mail { 'test1@example.com' }
    password { 'password' }
  end
end
