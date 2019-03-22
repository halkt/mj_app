class GameDetail < ApplicationRecord
  # リレーション定義
  belongs_to :game
  belongs_to :user

  # バリデーション
  validates :point, numericality: true, length: { maximum: 8 }

end
