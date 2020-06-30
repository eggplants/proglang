# -*- coding: utf-8 -*-

require 'ruby2d'

# 操作方法：
#  h,j,k,l：図形の移動
#  r：図形の回転
#  c: 長方形の色ランダム変更
#  q：閉じる

# 円を表現するクラス
class MyCircle < Circle
  def initialize(*arg)
    super(*arg)
  end
  
  def move(dx, dy)
    self.x += dx
    self.y += dy
  end

  def rotate
    nil
  end
end

# 点を表現するクラス
class MyPoint < MyCircle
  def initialize(*arg) # オーバーライド
    super(*arg)
    @radius = 1
  end
end

# 長方形を表現するクラス
class MyRectangle < Rectangle
  def move(dx, dy)
    self.x += dx
    self.y += dy
  end

  def rotate
    # 90度倒す
    newx = self.x + self.width/2 - self.height/2
    newy = self.y + self.height/2 - self.width/2
    neww = self.height
    newh = self.width
    self.x = newx
    self.y = newy
    self.width = neww
    self.height = newh
  end
end

class MyRandomlyColoredRectangle < MyRectangle
  def change_color
    self.color = (1..4).map{ Random.rand }
  end
end

def main
  # ウィンドウのタイトルとサイズを指定
  set title:"tags vs. interfaces", width:320, height:200
  # 幾つか図形を生成
  objs = [
    MyPoint.new(x:20, y:30, color:'red'),
    MyPoint.new(x:60, y:20, color:[0.0, 1.0, 0.0, 1.0]),
    MyCircle.new(x:40, y:80, radius:10, color:[0.5, 0.5, 0.5, 0.5]),
    MyRectangle.new(x:20, y:120, width:20, height:50, color:'teal'),
    MyRectangle.new(x:120, y:40, width:40, height:30, color:['red', 'green', 'blue', 'yellow']),
    MyRandomlyColoredRectangle.new(x:200, y:50, width:30, height:40)
  ]

  # キーが押された時に呼び出される手続き
  on :key_down do |event|
    case event.key
    when 'c' # ランダムに長方形の色を変える
      objs.filter{ |obj| obj.kind_of?(MyRandomlyColoredRectangle) }
          .each  { |obj| obj.change_color }
    when 'h' # 全図形を左に移動
      objs.each { |obj| obj.move(-5, 0) }
    when 'j' # 全図形を下に移動
      objs.each { |obj| obj.move(0, 5) }
    when 'k' # 全図形を上に移動
      objs.each { |obj| obj.move(0, -5) }
    when 'l' # 全図形を右に移動
      objs.each { |obj| obj.move(5, 0) }
    when 'q' # 終了
      close
    when 'r' # 全図形を回転
      objs.each { |obj| obj.rotate }
    when 'u'
      t = 0
      <<~USAGE.split(?\n).each{ Text.new(_1, x: 20, y: (t += 1)*30, size: 10, color: 'blue') }
        # USAGE:
        #  h,j,k,l: MOVE
        #  r: ROTATE
        #  c: COLORIZE(RECTANGLE)
        #  q: QUIT
      USAGE
    end
  end

  #ウィンドウを表示する
  show
  return 0
end

exit(main)

# EOS