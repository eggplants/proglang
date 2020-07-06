# 2020年度プログラム言語論 課題４レポート

- 201811528 春名航亨 (知識情報・図書館学類 3年次)

## 4-1: オブジェクト

### a) OOPでデータ構造の定義とその操作の定義をひとまとめに行う利点

- 量の多い処理をクラス/モジュールなどにまとめておいて、簡単に外部からクラスインスタンスなどを用いて読み出すことで、カプセル化された変数や関数に簡単にアクセスできる。
- また詳細な処理を読むことなく、情報隠蔽された状態でその機能だけを使うことができる。

## 4-2: オブジェクト指向言語の4基本概念（1~2文）

### a) dynamic lookup（動的ルックアップ）

- オブジェクトに対してのメソッド実行時に、そのオブジェクトによって実行されるメソッドが選択される仕組み。
- dynamic dispatch（動的ディスパッチ）とも。

### b) abstraction（抽象化）

- オブジェクトの定義やそれを扱う処理をオブジェクト外から直接参照できなくし隠蔽する仕組み。
- 抽象化した処理は外部から使用可能か（公開/非公開か）を選択できる。

### c) subtyping（サブタイピング）

- オブジェクトAの機能にオブジェクトBの機能が包含されているなら、Bが使える場所でAも置き換えて使えるという仕組み。

### d) inheritance（継承）

- 別のオブジェクトの定義を親として引き継いで、オブジェクトの定義を行える仕組み。
- 引き継いだ定義にコードを継ぎ足すことでコーディングの労を減らせる。

## 4-3: Rubyに触れてみる

### a)

- 前者ではa, bには別々の配列を指すアドレスが入っているが、後者では同一アドレスが入っている。
- そのため前者はaに行った変更はbには影響していないが、後者では伝播している。

## 4-4: オブジェクトvs.type-case

### a)

- 以下にi, iiを踏まえて改良したコードを載せる。

```ruby
#!/usr/bin/ruby
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
    end
  end

  #ウィンドウを表示する
  show
  return 0
end

exit(main)

# EOS
```

### b)

- 継承したことによりサブタイピングの関係になったため。

### c)

- `MyTriangle`追加の際、
  - `rotate`のために図形のタグをイニシャライザにもたせ、それを返す`shape`を記述する必要がなくなり記述量が減少した。
  - 最初の方は継承されていてかつオーバライドの必要のないイニシャライザやメソッドが書かれていて冗長であったため、それを削除したことにより追加時理解すべきコード量が削減されたと言える。

## 4-5: プログラミング言語関係の用語調査（100字程度）

### a) aspect-oriented programming（アスペクト指向プログラミング）

- プログラムを機能(アスペクト)ごとに分離して記述し、プログラム中の様々な対象に適用できるようにする手法。
- AOPの機能を既存の言語に追加するフレームワークとして、Java言語のSpringが有名。(97文字)

### b) byte code（バイトコード）

- 仮想マシンの仮想CPUのために設計された命令コードの体系とそれを用いて記述された実行プログラム。
- VM上で実行する際には環境のCPU固有の命令セットを用いたマシン語(ネイティブコード)にコンパイルされる。(101文字)

### c) pair programming（ペアプログラミング）

- 共同で2人が「ドライバー（コーディング）」役と「ナビゲーター（指示）」役に分かれプログラムを作成する開発手法。
- 作成中の相互の対話の中でのメンバー同士での知識の共有や、コードの品質向上が見込める。(97文字)

### d) refactoring（リファクタリング）

- プログラムの外部から見た動作を変えずにソースコードの内部構造を整理し複雑さを減らすこと。
- これにより可読性の向上、修正や拡張、またはバグの発見を容易にし、コードのメンテナビリティの向上が見込める。(97文字)

### e) Just-In-Time compiler（JITコンパイラ）

- プログラムが実行される「まさにその時(Just-In-Time)」にコンパイルし実行速度の向上を図るコンパイラ。
- 実行要求〜コンパイル〜実行開始の時間はかかるが、コンパイル後の実行速度は高速化される利点を持つ。(104文字)

### f) version control system（バージョン管理システム）

- 主にソースコードファイルの削除/作成/追加などの変更履歴を差分として管理するシステム。
- 過去の状態や変更内容を確認、変更前の状態を復元できる他、チーム開発で同一ファイルへの編集の競合を解決する機能も提供する。(103文字)
