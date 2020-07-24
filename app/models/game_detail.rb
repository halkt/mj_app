# frozen_string_literal: true

class GameDetail < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :point, presence: true, numericality: true, length: { maximum: 8 }
  validates :user_id, uniqueness: { scope: :game_id }

  # 特定のゲームの個人の詳細
  scope :user_records, (lambda do |game_id, user_id|
    where(game_id: game_id).where(user_id: user_id)
  end)

  scope :group_by_sum_score, (lambda do
    order('sum_score desc').group(:user_id).sum(:score)
  end)

  def update_rank(rank)
    self.rank = rank
    save!
  end

  def update_score
    horse = Horse.find(game.horse_id)
    self.score = calculate_score(horse)
    save!
  end

  def calc_horse(horse)
    case rank
    when 1
      point + horse.point2
    when 2
      point + horse.point1
    when 3
      point - horse.point1
    when 4
      point - horse.point2
    end
  end

  private

  def calculate_score(horse)
    sum_point = calc_horse(horse) - game.kaeshiten
    sum_point += (game.kaeshiten - game.genten) * 4 if rank == 1
    sum_point.to_f / 1000
  end
end
