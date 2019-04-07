class RankingsController < ApplicationController
  def show
    @gamedetails = GameDetail.limit(10).order('sum_score desc').group(:user_id).sum(:score)
  end
end
