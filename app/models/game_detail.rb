class GameDetail < ApplicationRecord
  belongs_to :game

  # コールバック関数の設定
  before_save :calc_score

  private

  def calc_score
    # ウマ計算
    score = calc_horse
    score = score - game.kaeshiten

    # 1位の場合のみオカを加算する
    if self.rank == 1
      score = score + (game.kaeshiten - game.genten)*4
    end

    score = score/1000
    # スコアに代入する
    self.score = score
  end

  def calc_horse
    case self.rank
      when 1 then
        self.point + Horse.find(game.horse_id).point2
      when 2 then
        self.point + Horse.find(game.horse_id).point1
      when 3 then
        self.point - Horse.find(game.horse_id).point1
      when 4 then
        self.point - Horse.find(game.horse_id).point2
    end
  end
end
