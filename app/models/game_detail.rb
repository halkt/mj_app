class GameDetail < ApplicationRecord
  # リレーション定義
  belongs_to :game
  belongs_to :user

  # バリデーション
  validates :point, presence: true, numericality: true, length: { maximum: 8 }
  validates :user_id, :uniqueness => {:scope => :game_id} #ユーザーIDとゲームIDの組み合わせは一意
end
