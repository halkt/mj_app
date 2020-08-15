# frozen_string_literal: true

FactoryBot.define do
  factory :horse do
    name { '5-10' }
    point1 { 10_000 }
    point2 { 5_000 }
  end
end
