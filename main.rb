class Brave
  #  アクセスメソッド START
  # attr_readerの記述でゲッターを省略することができる
  # attr_reader :name
  # attr_reader :hp
  # attr_reader :offense
  # attr_reader :defense

  # 上の複数の値を同時に指定することができる
  # attr_reader :name, :hp, :offense, :defense
  attr_reader :name, :offense, :defense


  # セッターを省略する場合はattr_writerを使用します。
  # attr_writer :hp

  # セッターゲッターを一括定義
  attr_accessor :hp
  #  アクセスメソッド END

  # 必殺攻撃の計算に使う定数
  SPECIAL_ATTACK_CONSTANT = 1.5

  # Rubyにはinitializeメソッドというものが存在します。このinitializeメソッドは、インスタンス化されると同時に実行されるメソッドなので、クラスのインスタンス変数に初期値を設定したい場合にとても便利です。
  # セッターを変数ごとに定義しなくても、まとめて初期値を設定できるので、コードの記述量を減らす事ができる。
  # initializeメソッドを定義

  # ⓪直下のままだと、テリーの初期データしか作成出来ない
  # def initialize
  #   @name = 'テリー'
  #   @hp = 500
  #   @offense = 150
  #   @defense = 100
  # end

  # new演算子から渡された引数を受け取る
  # このように変数を定義してnewインスタンスを作成した時に、
  # ①引数でデータを代入する事でたくさんのデータの初期値データ
  # def initialize(name, hp, offense, defense)
  #   @name = name
  #   @hp = hp
  #   @offense = offense
  #   @defense = defense
  # end

   # ②new演算子から渡された引数を受け取る 今はinitializeメソッドの引数としてname、hp、offense、defenseの3つを設定しているのですが、引数を見ただけではどのパラメータに値を渡しているのかがわかりません。そこで、main.rbのinitializeメソッドを編集してもっとわかりやすくしていきましょう。そのときに使用するのがキーワード引数です。
  #  def initialize(name:, hp:, offense:, defense:)
  #   @name = name
  #   @hp = hp
  #   @offense = offense
  #   @defense = defense
  # end

  # ③今のままではnew演算子で渡す引数の数が増えるとinitializeメソッドの引数も増やす必要があり、変更箇所が多くなってしまいます。なので、以下のようにmain.rbのinitializeメソッドの引数を変更し、ハッシュとして値を受け取れるようにしましょう。こうすることで、new演算子で渡す引数の数が増えても変更箇所が少なくて済みます。
  # paramsで一括で受け取る
  # def initialize(params)
  #   # 各パラメータをハッシュで取得
  #   @name = params[:name]
  #   @hp = params[:hp]
  #   @offense = params[:offense]
  #   @defense = params[:defense]
  # end

  # ④initializeに渡す引数はnew演算子においてhp: 500, offense: 150, defense: 100というようなハッシュの形式（キーとバリューの組み合わせ）となっています。そのため、main.rbのinitializeに渡せる引数はハッシュのみになるよう限定してあげましょう。そうすることで、ハッシュ以外の値を引数で渡した場合エラーとなってくれるので、予期せぬバグが発生しにくくなります。
  # 引数に**を記述：ハッシュしか受け取れなくなる
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end


  # 勇者にはname、hp、offense、defenseの3つのパラメータが存在します。まずは、それらのパラメータに値を設定できるようにしましょう。その際に定義するのは「セッター」です。
  # セッターとは、インスタンス変数の値をクラス内で更新するためのメソッドです。そのセッターで、引数で受け取った値をインスタンス変数に代入します。
  # nameのセッター
  # def name=(name)
  #   @name = name
  # end
  # @name

  # 勇者のパラメータを設定できたら、次はそれを取り出します。まずはゲッターを定義しましょう。
  # ゲッターとは、クラス内にあるインスタンス変数の値を取得し、クラス外から参照できるようにするためのメソッドです。
  # nameのゲッター
  # def name
  #   @name
  # end
  
  # hpのセッター
  # def hp=(hp)
  #   @hp = hp
  # end
  # @hp

  # hpのゲッター
  # def hp
  #   @hp
  # end

  # offenseのセッター
  # def offense=(offense)
  #   @offense = offense
  # end
  # @offense

  # offenseのゲッター
  # def offense
  #   @offense
  # end

  # defenseのセッター
  # def defense=(defense)
  #   @defense = defense
  # end
  # @defense

  # defenseのゲッター
  # def defense
  #   @defense
  # end

  # 引数でモンスタークラスのインスタンスを受け取る
  def attack(monster)
    # モンスタークラスのインスタンスが参照できているか確かめる
    puts "テスト：#{monster.name}のHPを表示 -> #{monster.hp}"
    # 以下の2行は削除
    # @offense：勇者インスタンスの攻撃力
    # monster.defense：モンスターインスタンスの防御力

    # ダメージ計算の処理を追加
    # damage = @offense - monster.defense
    # puts damage
    # モンスターのHPから計算したダメージを引く
    # puts monster.hp - damage
    # monster.hp - damage
    # メッセージを追記
    puts "#{@name}の攻撃"

    # 0~3の間でランダムに数字が変わる
    attack_num = rand(4)

    # 4分の1の確率でspecial_attackを実行
    if attack_num == 0
      # damage = calculate_special_attack
      # 必殺攻撃の表示
      puts "必殺攻撃"
      # calculate_special_attackの呼び出し
      # 攻撃力の1.5倍の数値が戻り値として返ってくる
      damage = calculate_special_attack - monster.defense
    else
      # damage = @offense - monster.defense
      # 通常攻撃の表示
      puts "通常攻撃"
      damage = @offense - monster.defense
    end

    # ダメージを与えられたHPをモンスターインスタンスのHPに代入
    # monster.hp = monster.hp - damage
    # 自己代入：monster.hpからdamageを引いた値をmonster.hpに代入
    monster.hp -= damage

    puts "#{monster.name}は#{damage}のダメージを受けた"
    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  def calculate_special_attack
    # special_attackが実行されているか確かめるためのテスト
    puts "calculate_special_attackが呼び出されました"
    # 攻撃力が1.5倍
    # @offense * 1.5
    @offense * SPECIAL_ATTACK_CONSTANT
  end
end

class Monster
  attr_reader :offense, :defense
  attr_accessor :name, :hp

  POWER_UP_DATE = 1.5
  CALC_HALF_HP = 0.5
  
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
    @transform = false
    @transform_hp =  params[:hp] * CALC_HALF_HP
  end

  def attack(brave)

    if @transform == false && @hp <= @transform_hp
      @transform = true
      transform
      # puts "ドラゴンの攻撃"
    else
      # puts "スライムの攻撃"
    end
    damage = @offense - brave.defense
    puts "#{@name}の攻撃"
    brave.hp -= damage
    puts "テリーは#{damage}のダメージを受けた"
    puts "テリーの残りHPは#{brave.hp}だ"
  end
  
  # クラス外から呼び出せないようにする
  private
  
  # 変身メソッドの定義
  def transform
    transform_name = "ドラゴン"
    puts "#{@name}は怒っている"
    puts "#{@name}は#{transform_name}に変身した"
    @offense *= POWER_UP_DATE
    @name = transform_name
  end
end

# ⓪勇者クラスをインスタンス化
# brave = Brave.new

# ①パラメータの値をinitializeに渡す
# brave = Brave.new("テリー", 500, 150, 100)

# ②、③パラメータの値をinitializeにキーワード引数として渡す
brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)

monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

# ⓪パラメータに値を設定 initializeメソッドで定義したので記述の必要無し。
# brave.name = 'テリー'
# brave.hp = 500
# brave.offense = 150
# brave.defense = 100

# ⓪値を取り出す putsで出力方法①
# puts brave.name
# puts brave.hp
# puts brave.offense
# puts brave.defense

# ⓪値を取り出す putsで出力方法②
# puts "NAME：#{brave.name}"
# puts "HP：#{brave.hp}"
# puts "OFFENSE：#{brave.offense}"
# puts "DEFENSE：#{brave.defense}"

# ヒアドキュメントの記法 putsで出力方法③
# puts <<~TEXT
# NAME：#{brave.name}
# HP：#{brave.hp}
# OFFENSE：#{brave.offense}
# DEFENSE：#{brave.defense}
# TEXT

# puts <<~TEXT
# NAME:#{monster.name}
# HP:#{monster.hp}
# OFFENSE:#{monster.offense}
# DEFENSE:#{monster.defense}
# TEXT

# hpにダメージを与える処理
# brave.hp -= 30

# ダメージに関するメッセージ
# puts "#{brave.name}はダメージを受けた! 残りHPは#{brave.hp}だ"

# 勇者インスタンスがモンスターインスタンスに攻撃を加える
brave.attack(monster)

# こちらのメソッドを実装
monster.attack(brave)