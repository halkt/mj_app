# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#update_details' do
    before { game.update_details }
    let!(:game) { FactoryBot.create(:game) }
    it 'game_detailが更新されていること' do
      expect(game.reload.game_detail.pluck(:rank)).to eq [1, 2, 3, 4]
      expect(game.reload.game_detail.pluck(:score)).to eq [30.0, 1.0, -11.0, -20.0]
    end
  end
end
