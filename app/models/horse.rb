# frozen_string_literal: true

class Horse < ApplicationRecord
  # リレーション定義
  has_many :games, dependent: :restrict_with_error # 他のテーブルで利用されている場合エラー

  # バリデーション
  validates :name,
            presence: true,
            uniqueness: true,
            length: { maximum: 20 }
  validates :point1,
            presence: true,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 100_000 }
  validates :point2,
            presence: true,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 100_000 }
  validate :point_check, if: :point_nil_check?

  private

  def point_check
    return if point1 > point2

    errors.add(:horse, 'point1はpoint2より小さい点数を入力してください')
  end

  # ポイント1もしくはポイント2がnilの場合、false
  def point_nil_check?
    point1.present? && point2.present?
  end
end
