class RankingsController < ApplicationController
  def show
    # すべての起点
    @gamedetails = GameDetail.limit(10).order('sum_score desc').group(:user_id).sum(:score)


  end
end
