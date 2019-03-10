class User < ApplicationRecord
  # リレーションの定義
  has_many :event_users, :dependent => :destroy
  has_many :events, through: :event_users
  has_many :game_detail, :dependent => :destroy

  # 名称のバリデーションチェック
  validates :name, presence: true, length: { maximum: 50 }

  # メールアドレスのバリデーションチェック
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :mail,  length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true,
                    allow_nil: true

  # 説明のバリデーションチェック
  validates :description, length: { maximum: 140 }
end
