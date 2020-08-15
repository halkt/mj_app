# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    mail { "test#{SecureRandom.alphanumeric(10)}@example.com" }
    password { 'password' }
    login_flg { true }
  end
end
