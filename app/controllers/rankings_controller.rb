class RankingsController < ApplicationController
  def show
    @gamedetails = GameDetail.group_by_sum_score
  end
end
