class Event < ApplicationRecord
  # リレーション定義
  has_many :event_users, :dependent => :destroy
  has_many :users, through: :event_users
  has_many :games, :dependent => :destroy
  belongs_to :community
  accepts_nested_attributes_for :event_users, allow_destroy: true

  # バリデーション
  validates :name, presence: true, length: { maximum: 50 }
  validates :day, presence: true
  validates :description, length: { maximum: 140 }

  # イベントのユーザーの合計スコアを返す
  def sum_user_score(user_id)
    sum_user_score = 0
    user_records = GameDetail.where(user_id: user_id).where(game_id: games.pluck(:id))
    user_records.each do |user_record|
      sum_user_score += user_record.score
    end
    sum_user_score
  end

  # イベントのユーザーの合計スコアを返す
  def user_rank(user_id)
    hash_users_rank[user_id][:rank]
  end

  private

  # 合計スコアを元にユーザーの順位を返す
  def hash_users_rank
    hash = {}
    users.each_with_index do |user, index|
      hash[user.id] = {}
      hash[user.id][:sum_score] = sum_user_score(user.id)
      hash[user.id][:rank] = array_rank[index]
    end
    hash
  end

  # 合計得点を元に順位の配列を返す
  def array_rank
    score_array = []
    users.each do |user|
      score_array.push(sum_user_score(user.id))
    end
    score_array.map { |v| score_array.count { |a| a > v } + 1 }
  end
end
