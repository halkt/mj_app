class Community < ApplicationRecord
    has_many :community_users
    has_many :users, through: :community_users
    has_many :events

    # 特定のユーザーが所属しているコミュニティ
    scope :affiliation_user, -> (user_id) { joins(:users).where(users: {id: user_id}) }
end
