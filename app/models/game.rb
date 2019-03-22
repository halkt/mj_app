class Game < ApplicationRecord
  # リレーションを定義する
  belongs_to :event
  belongs_to :horse
  has_many :game_detail, :dependent => :destroy # 他テーブルの情報もまとめて削除する
  accepts_nested_attributes_for :game_detail, allow_destroy: true, limit: 4

  # バリデーション
  validates :genten, numericality: true, length: { maximum: 5 }
  validates :kaeshiten, numericality: true, length: { maximum: 5 }
  validates :description, length: { maximum: 140 }

  # コールバック関数の設定
  before_save :calc_score
  before_update :calc_score

  # プライベートメソッドの定義
  private

  def calc_score
    i = 0
    self.game_detail.order(point: "DESC").each do |gamedetail|
      i += 1
      gamedetail.attributes = {rank: i}
      score = calc_horse(gamedetail) # ウマ計算
      score = score - self.kaeshiten

      # 1位の場合のみオカを加算する
      if gamedetail.rank == 1
        score = score + (self.kaeshiten - self.genten)*4
      end

      score = score/1000

      # 更新
      gamedetail.attributes = {score: score}
      gamedetail.save!
    end
  end

  def calc_horse(gamedetail)
    case gamedetail.rank
      when 1 then
        gamedetail.point + Horse.find(self.horse_id).point2
      when 2 then
        gamedetail.point + Horse.find(self.horse_id).point1
      when 3 then
        gamedetail.point - Horse.find(self.horse_id).point1
      when 4 then
        gamedetail.point - Horse.find(self.horse_id).point2
      else
        exit # とりあえずは
    end
  end

end
