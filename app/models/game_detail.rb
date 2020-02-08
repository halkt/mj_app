class GameDetail < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :point, presence: true, numericality: true, length: { maximum: 8 }
  validates :user_id, :uniqueness => {:scope => :game_id} #ユーザーIDとゲームIDの組み合わせは一意

  # 特定のゲームの個人の詳細
  scope :user_records, -> (game_id, user_id) { where(game_id: game_id).where(user_id: user_id) }
end
