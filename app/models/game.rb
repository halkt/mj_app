class Game < ApplicationRecord
  # リレーションを定義する
  belongs_to :event
  belongs_to :horse
  has_many :game_detail, :dependent => :destroy # 他テーブルの情報もまとめて削除する
  accepts_nested_attributes_for :game_detail, allow_destroy: true, limit: 4

  # バリデーション
  validates :genten, presence: true, numericality: true, length: { maximum: 5 }
  validates :kaeshiten, presence: true, numericality: true, length: { maximum: 5 }
  validates :description, length: { maximum: 140 }
  validate :pointCheck
  validate :userCheck



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
        exit
    end
  end

  # [エラーチェック]合計点数の妥当性のチェック
  def pointCheck
    sum = 0
    self.game_detail.each do |x|
      sum += x.point
    end
    total = self.genten * 4
    errors.add(:base, "点棒の合計点数が「#{sum.to_s(:delimited)}点」です。「#{total.to_s(:delimited)}点」になるよう再入力してください。") if total != sum
  end

  # [エラーチェック]同じユーザーが登録されていないこと
  def userCheck
    userAry = Array.new
    self.game_detail.each do |user|
      if userAry.include?(user.user_id)
        errors.add(:base, "「#{user.user.name}」が重複しています。")
      else
        userAry.push(user.user_id)# user追加
      end
    end
  end

end
