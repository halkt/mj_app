class Game < ApplicationRecord
  belongs_to :event
  has_many :game_detail
  accepts_nested_attributes_for :game_detail, allow_destroy: true, limit: 4
  # 同時に変更できる数を指定
end
