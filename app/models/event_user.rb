class EventUser < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :user_id, :uniqueness => {:scope => :event_id} #ユーザーIDとイベントIDの組み合わせは一意

end
