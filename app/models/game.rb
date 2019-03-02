class Game < ApplicationRecord
  # リレーションを定義する
  belongs_to :event
  belongs_to :horse
  has_many :game_detail
  accepts_nested_attributes_for :game_detail, allow_destroy: true, limit: 4

  # バリデーション
  validates :genten, numericality: true, length: { maximum: 5 }
  validates :kaeshiten, numericality: true, length: { maximum: 5 }
  validates :tobi_rule, inclusion: { in: 0..1 }
  validates :yakitori_rule, inclusion: { in: 0..1 }
  validates :description, length: { maximum: 140 }

end
