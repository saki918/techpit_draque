class Brave
  attr_reader :name, :offense, :defense
  attr_accessor :hp

  SPECIAL_ATTACK_CONSTANT = 1.5

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

  def attack(monster)
    puts "#{@name}の攻撃"

    # decision_attack_typeメソッドの呼び出し
    attack_type = decision_attack_type

    # calculate_damageメソッドの呼び出し
    # damage = calculate_damage(monster, attack_type)
    
    # ダメージをHPに反映させる
    # cause_damage(monster, damage)

    # キーワード引数を設定
    damage = calculate_damage(target: monster, attack_type: attack_type)
    # キーワード引数を設定
    cause_damage(target: monster, damage: damage)

    # attack_typeを用いて攻撃処理を振り分け
    # if attack_type == "special_attack"
      # puts "必殺攻撃"
      # damage = calculate_special_attack - monster.defense
    # else
      # puts "通常攻撃"
      # damage = @offense - monster.defense
    # end


    # monster.hp -= damage

    # puts "#{monster.name}は#{damage}のダメージを受けた"
    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  # 勇者クラスで定義したdecision_attack_type calculate_damage cause_damage calculate_special_attackに関しては、クラス外から呼び出される必要のないメソッドなので、privateメソッドにしてあげましょう。
  private

  # 攻撃の種類（通常攻撃 or 必殺攻撃）を判定するメソッド
  def decision_attack_type
    attack_num = rand(4)

    if attack_num == 0
      puts "必殺攻撃"
      "special_attack"
    else
      puts "通常攻撃"
      "normal_attack"
    end
  end

  # ダメージの計算メソッド
  # def calculate_damage(monster, attack_type)
  #   if attack_type == "special_attack"
  #     calculate_special_attack - monster.defense
  #   else
  #     @offense - monster.defense
  #   end
  # end

  # **paramsで受け取る
  def calculate_damage(**params)
    # 変数に格納することによって将来ハッシュのキーに変更があった場合でも変更箇所が少なくて済む
    target = params[:target]
    attack_type = params[:attack_type]

    if attack_type == "special_attack"
      calculate_special_attack - target.defense
    else
      @offense - target.defense
    end
  end

  # HPにダメージを反映させる
  # def cause_damage(monster, damage)
  #   monster.hp -= damage
  #   puts "#{monster.name}は#{damage}のダメージを受けた"
  # end

  # paramsで受け取る
  def cause_damage(**params)
    # 変数に格納することによって将来ハッシュのキーに変更があった場合でも変更箇所が少なくて済む
    damage = params[:damage]
    target = params[:target]

    target.hp -= damage

    # もしターゲットのHPがマイナスになるなら0を代入
    target.hp = 0 if target.hp < 0

    puts "#{target.name}は#{damage}のダメージを受けた"
  end

  def calculate_special_attack
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
    puts "#{@name}の攻撃"

    # decision_attack_typeメソッドの呼び出し
    transform = decision_transform

     # キーワード引数を設定
     damage = calculate_damage(target: brave, transform: transform)
     # キーワード引数を設定
     cause_damage(target: brave, damage: damage)

    damage = @offense - brave.defense
    puts "テリーの残りHPは#{brave.hp}だ"
  end
  
  # クラス外から呼び出せないようにする
  private
  
  # 変身メソッドの定義
  def transform
    transform_name = "ドラゴン"
    puts "#{@name}は怒っている"
    puts "#{@name}は#{transform_name}に変身した"
    @name = transform_name
  end

  # 攻撃の種類 変身の有無
  def decision_transform
    if @transform == false && @hp <= @transform_hp
      @transform = true
      transform
    end
  end
  
  # **paramsで受け取る
  def calculate_damage(**params)
    # 変数に格納することによって将来ハッシュのキーに変更があった場合でも変更箇所が少なくて済む
    target = params[:target]
    transform = params[:transform]

    if @transform == true
      @offense *= POWER_UP_DATE
    else
      @offense - target.defense
    end
  end

  # paramsで受け取る
  def cause_damage(**params)
    # 変数に格納することによって将来ハッシュのキーに変更があった場合でも変更箇所が少なくて済む
    damage = params[:damage]
    target = params[:target]

    target.hp -= damage

    # もしターゲットのHPがマイナスになるなら0を代入
    target.hp = 0 if target.hp < 0

    puts "#{target.name}は#{damage}のダメージを受けた"
  end

end

# 途中のコードは省略
# brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)

# monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

# # ループ処理
# loop do
#   brave.attack(monster)

#   # モンスターのHPが0以下になったら無限ループを終了させる
#   # if monster.hp <= 0
#   #   break
#   # end
#   # 1行で記述
#   break if monster.hp <= 0

#   monster.attack(brave)

#   # 勇者のHPが0以下になったら無限ループを終了させる
#   # if brave.hp <= 0
#   #   break
#   # end
#    # 1行で記述
#    break if brave.hp <= 0

# end

# # 勝敗の判定
# battle_result = brave.hp > 0

# # 勇者が勝利した場合の処理
# if battle_result
#   exp = (monster.offense + monster.defense) * 2
#   gold = (monster.offense + monster.defense) * 3
#   puts "#{brave.name}はたたかいに勝った"
#   puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
# else
#   puts "#{brave.name}はたたかいに負けた"
#   puts "目の前が真っ暗になった"
# end
# これらがもし、ひとまとめにされていた場合は以下のようなコードになります。

brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

# 繰り返し処理・攻撃処理・勝敗の判定・経験値とゴールドの計算処理がひとまとめになっている
loop do
  brave.attack(monster)
  if monster.hp <= 0
    exp = (monster.offense + monster.defense) * 2
    gold = (monster.offense + monster.defense) * 3
    puts "#{brave.name}はたたかいに勝った"
    puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
    break
  end

  monster.attack(brave)
  if brave.hp <= 0
    puts "#{brave.name}はたたかいに負けた"
    puts "目の前が真っ暗になった"
    break
  end
end