# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :event
  belongs_to :horse
  has_many :game_detail, dependent: :destroy
  accepts_nested_attributes_for :game_detail, allow_destroy: true, limit: 4

  # バリデーション
  validates :genten,
            presence: true,
            numericality: true,
            length: { maximum: 5 }
  validates :kaeshiten,
            presence: true,
            numericality: true,
            length: { maximum: 5 }
  validates :description, length: { maximum: 140 }
  validate :sum_point_check
  validate :user_check

  # コールバック関数の設定
  before_save :update_details
  before_update :update_details

  # ポイントからスコアを計算して保存する
  def update_details
    game_detail.order(point: :desc).each_with_index do |detail, index|
      detail.update_rank(index + 1)
      detail.update_score
    end
  end

  private

  # [エラーチェック]合計点数の妥当性のチェック
  def sum_point_check
    expected_sum_point = genten * 4
    sum_point = game_detail.pluck(:point).sum
    return if expected_sum_point == sum_point

    error_message = generate_error_message_for_point(expected_sum_point,
                                                     sum_point)
    errors.add(:base, error_message)
  end

  # [エラーチェック]同じユーザーが登録されていないこと
  def user_check
    user_ids = game_detail.pluck(:user_id)
    return if (user_ids.count - user_ids.uniq.count).zero?

    errors.add(:base, 'ユーザーが重複しています。')
  end

  def generate_error_message_for_point(expected_sum_point, sum_point)
    text1 = "点棒の合計点数が「#{sum_point.to_s(:delimited)}点」です。"
    text2 = "「#{expected_sum_point.to_s(:delimited)}点」になるよう再入力してください。"
    text1 + text2
  end
end
