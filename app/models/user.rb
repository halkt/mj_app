class User < ApplicationRecord
  # digest作成用の関数を宣言
  has_secure_password(validations: false)

  # リレーションの定義
  has_many :event_users, :dependent => :destroy # 他テーブルの情報もまとめて削除する
  has_many :events, through: :event_users
  has_many :game_detail, dependent: :restrict_with_error # 他のテーブルで利用されている場合エラー

  # 名称のバリデーションチェック
  validates :name, presence: true, length: { maximum: 50 }

  # メールアドレスのバリデーションチェック
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :mail,  length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true,
                    allow_nil: true,
                    allow_blank: true

  # メールアドレスは小文字で登録する
  before_save   :downcase_mail

  # adminのバリデーションチェック
  validates :admin, inclusion: {in: [true, false]}

  # login_flgのバリデーションチェック
  validates :login_flg, inclusion: {in: [true, false]}

  # パスワードの長さを定義する。空更新を許可する
  validates :password, presence: true, if: :login_flg?
  validates :password, length: { minimum: 6 }, allow_nil: true, allow_blank: true
  
  # 説明のバリデーションチェック
  validates :description, length: { maximum: 140 }

  private

  # メールアドレスをすべて小文字にする
  def downcase_mail
    self.mail.downcase!
  end

end
