# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#sum_user_score' do
    subject { event.sum_user_score(user.id) }
    before { game.update_details }

    let!(:game) { FactoryBot.create(:game) }
    let!(:event) { game.event }

    context do
      let!(:user) { game.game_detail.first.user }
      it { is_expected.to eq 30.0 }
    end
  end

  describe '#user_rank' do
    # TODO
    # subject { event.user_rank(user.id) }
    # before { game.update_details }

    # let!(:game) { FactoryBot.create(:game) }
    # let!(:event) { game.event }

    # context do
    #   let!(:user) { game.game_detail.first.user }
    #   it { is_expected.to eq 30.0 }
    # end
  end
end
