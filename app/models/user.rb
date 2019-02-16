class User < ApplicationRecord
  validates :name, presence: true
  has_many :event_users, :dependent => :destroy
  has_many :events, through: :event_users
end
