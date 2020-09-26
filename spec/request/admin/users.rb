# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::UsersController, type: :request do
  let!(:user) do
    FactoryBot.create(
      :user,
      admin: true,
      login_flg: true)
  end

  describe 'GET /admin/users/:id/edit', :login do
    it '200が返ること' do
      get edit_admin_user_path(user.id)
      expect(response).to have_http_status(200)
    end
  end
end
