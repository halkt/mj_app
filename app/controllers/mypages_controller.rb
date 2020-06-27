# frozen_string_literal: true

class MypagesController < ApplicationController
  def show
    @gamedetails = GameDetail.where(user_id: current_user.id)
    @recent_details = @gamedetails.order(id: :desc).limit(10)
    @chart = generate_chart
    set_average_variable
  end

  private

  def set_average_variable
    game_count = @gamedetails.count
    @average_score = @gamedetails.sum(:score) / game_count.to_f
    @average_rank = @gamedetails.sum(:rank) / game_count.to_f
    @average_top = @gamedetails.where(rank: 1).count / game_count.to_f * 100
  end

  def generate_chart
    top = @gamedetails.where(rank: 1).count
    second = @gamedetails.where(rank: 2).count
    third = @gamedetails.where(rank: 3).count
    last = @gamedetails.where(rank: 4).count
    [['1着', top], ['2着', second], ['3着', third], ['4着', last]]
  end
end
