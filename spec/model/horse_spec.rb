# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Horse, type: :model do
  describe '#point_check' do
    subject { horse.send(:point_check) }

    context 'point1 > point2の場合' do
      let(:horse) do
        Horse.new(name: 'test',
                  point1: 10_000,
                  point2: 5_000)
      end
      it { is_expected.to eq nil }
    end

    context 'point1 < point2の場合' do
      let(:horse) do
        Horse.new(name: 'test',
                  point1: 5_000,
                  point2: 10_000)
      end
      let(:expect_message) { ['point2はpoint1より小さい点数を入力してください'] }
      it { is_expected.to eq expect_message }
    end

    context 'point1 = point2の場合' do
      let!(:horse) do
        Horse.new(name: 'test',
                  point1: 0,
                  point2: 0)
      end
      it { is_expected.to eq nil }
    end
  end
end
