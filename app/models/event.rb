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
end
