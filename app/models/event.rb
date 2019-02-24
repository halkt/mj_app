class Event < ApplicationRecord
  validates :name, presence: true
  has_many :event_users, :dependent => :destroy
  has_many :users, through: :event_users
  has_many :games, :dependent => :destroy
end
