class Event < ApplicationRecord
  # リレーション定義
  has_many :event_users, :dependent => :destroy
  has_many :users, through: :event_users
  has_many :games, :dependent => :destroy
  accepts_nested_attributes_for :event_users, allow_destroy: true

  # バリデーション
  validates :name, presence: true
  validates :description, length: { maximum: 140 }
end
