# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#display_type_name' do
    subject { user.display_type_name }

    context '管理者の場合' do
      let!(:user) { FactoryBot.create(:user, admin: true, login_flg: true) }
      it { is_expected.to eq '管理者' }
    end

    context '一般（ログイン可能）の場合' do
      let!(:user) { FactoryBot.create(:user, admin: false, login_flg: true) }
      it { is_expected.to eq '一般（ログイン可能）' }
    end

    context 'ゲスト（ログイン不可）の場合' do
      let!(:user) { FactoryBot.create(:user, admin: false, login_flg: false) }
      it { is_expected.to eq 'ゲスト（ログイン不可）' }
    end
  end
end
