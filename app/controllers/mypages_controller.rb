class MypagesController < ApplicationController
  def show
    # すべての起点
    @gamedetails = GameDetail.where(user_id: current_user.id)

    # 合計対局数
    @counts = @gamedetails.count

    # スコア
    @scoreSum = @gamedetails.sum(:score)
    @scoreAvg = @scoreSum.to_f/@counts.to_f

    # 順位
    rankSum = @gamedetails.sum(:rank)
    @rankAvg = rankSum.to_f/@counts.to_f

    # 順位
    @rankSum = @gamedetails.sum(:rank)
    @rankAvg = @rankSum.to_f/@counts.to_f

    # 順位表示用変数
    top = @gamedetails.where(rank: 1).count
    second = @gamedetails.where(rank: 2).count
    third = @gamedetails.where(rank: 3).count
    last = @gamedetails.where(rank: 4).count

    # トップ率
    @topAvg = top.to_f/@counts.to_f*100

    # 円グラフ
    @chart = [['1着', top], ['2着', second], ['3着', third], ['4着', last]]

    # 最近の成績
    @recentdetails = @gamedetails.order(id: "DESC").limit(10)
  end
end
