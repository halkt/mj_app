# frozen_string_literal: true

class Community < ApplicationRecord
  has_many :community_users, dependent: :destroy
  has_many :users, through: :community_users
  has_many :events, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }

  # 特定のユーザーが所属しているコミュニティ
  scope :affiliation_user, (lambda do |user_id|
    joins(:users).where(users: { id: user_id })
  end)
end
