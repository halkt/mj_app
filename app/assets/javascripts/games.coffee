# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@calcLastPoint = ->
  # 変数定義
  sumGenten = document.getElementById('game_genten').value * 4
  point1 = document.getElementById('game_game_detail_attributes_0_point').value
  point2 = document.getElementById('game_game_detail_attributes_1_point').value
  point3 = document.getElementById('game_game_detail_attributes_2_point').value
  point4 = document.getElementById('game_game_detail_attributes_3_point').value
  points = [point1,point2,point3,point4]

  # 出力
  if oneNullCheck(points)
    point = sumGenten - arySum(points.map(Number))
    document.getElementById(getID(getFlg(points))).value = point
  return

# nullか空値かどうか判定する
isBlank = (val) ->
  val == null or val == ''

# 配列の値を合計する
arySum = (arr) ->
  `var sum`
  sum = 0
  arr.forEach (elm) ->
    sum += elm
    return
  sum

# 配列の空値を求める
oneNullCheck = (arr) ->
  i = 0
  arr.forEach (elm) ->
    if isBlank(elm)
      i += 1
    return
  if (i == 1)
    true
  else
    alert "3名分の点棒を入れているときにボタンを押してください。"
    false


# 配列の空値を求める
getFlg = (arr) ->
  i = 0
  flg = -1
  arr.some (elm) ->
    if isBlank(elm)
      flg = i
      return true
    i += 1
    return
  flg

# 配列によってフォームIDを返す
getID = (flg) ->
  switch flg
    when 0
      ID = 'game_game_detail_attributes_0_point'
    when 1
      ID = 'game_game_detail_attributes_1_point'
    when 2
      ID = 'game_game_detail_attributes_2_point'
    when 3
      ID = 'game_game_detail_attributes_3_point'
    else
      alert "すべての値を入力済みです"
  ID
