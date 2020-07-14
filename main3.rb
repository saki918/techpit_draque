# character.rbを読み込む：Characterクラスが使えるようになる
require './character'
# brave.rbを読み込む：Braveクラスが使えるようになる
require './brave'
# monster.rbを読み込む：Monsterクラスが使えるようになる
require './monster'
require './games_controller'

# 親クラス character.rb に移動
# class Character
#   attr_reader :offense, :defense
#   attr_accessor :hp, :name

#   def initialize(**params)
#     @name = params[:name]
#     @hp = params[:hp]
#     @offense = params[:offense]
#     @defense = params[:defense]
#   end
# end

# # Characterクラスを継承
# class Brave < Character
# # class Brave
#   # attr_reader :name, :offense, :defense
#   # attr_accessor :hp

#   SPECIAL_ATTACK_CONSTANT = 1.5

#   # def initialize(**params)
#   #   @name = params[:name]
#   #   @hp = params[:hp]
#   #   @offense = params[:offense]
#   #   @defense = params[:defense]
#   # end

#   def attack(monster)
#     puts "#{@name}の攻撃"

#     attack_type = decision_attack_type
#     damage = calculate_damage(target: monster, attack_type: attack_type)
#     cause_damage(target: monster, damage: damage)

#     puts "#{monster.name}の残りHPは#{monster.hp}だ"
#   end

#   private

#     def decision_attack_type
#       attack_num = rand(4)

#       if attack_num == 0
#         puts "必殺攻撃"
#         "special_attack"
#       else
#         puts "通常攻撃"
#         "normal_attack"
#       end
#     end

#     def calculate_damage(**params)
#       target = params[:target]
#       attack_type = params[:attack_type]

#       if attack_type == "special_attack"
#         calculate_special_attack - target.defense
#       else
#         @offense - target.defense
#       end
#     end

#     def cause_damage(**params)
#       damage = params[:damage]
#       target = params[:target]

#       target.hp -= damage
#       target.hp = 0 if target.hp < 0

#       puts "#{target.name}は#{damage}のダメージを受けた"
#     end

#     def calculate_special_attack
#       @offense * SPECIAL_ATTACK_CONSTANT
#     end
# end

# # Characterクラスを継承
# class Monster < Character
# # class Monster
#   # attr_reader :offense, :defense
#   # attr_accessor :hp, :name

#   POWER_UP_RATE = 1.5
#   CALC_HALF_HP = 0.5

#   def initialize(**params)
#     # @name = params[:name]
#     # @hp = params[:hp]
#     # @offense = params[:offense]
#     # @defense = params[:defense]

#     # キャラクタークラスのinitializeメソッドに処理を渡す
#     # 通常のメソッドと同様に引数を渡すことができる
#     super(
#       name: params[:name],
#       hp: params[:hp],
#       offense: params[:offense],
#       defense: params[:defense]
#     )

#     @transform_flag = false
#     @trigger_of_transform = params[:hp] * CALC_HALF_HP
#   end

#   def attack(brave)
#     if @hp <= @trigger_of_transform && @transform_flag == false

#       @transform_flag = true
#       transform
#     end

#     puts "#{@name}の攻撃"

#     damage = calculate_damage(brave)
#     cause_damage(target: brave, damage: damage)

#     puts "#{brave.name}の残りHPは#{brave.hp}だ"
#   end

#   private

#     def calculate_damage(target)
#       @offense - target.defense
#     end

#     def cause_damage(**params)
#       damage = params[:damage]
#       target = params[:target]

#       target.hp -= damage

#       # もしターゲットのHPがマイナスになるなら0を代入
#       target.hp = 0 if target.hp < 0

#       puts "#{target.name}は#{damage}のダメージを受けた"
#     end

#     def transform
#       transform_name = "ドラゴン"

#       puts <<~EOS
#       #{@name}は怒っている
#       #{@name}は#{transform_name}に変身した
#       EOS

#       @offense *= POWER_UP_RATE
#       @name = transform_name
#     end
# end

# 経験値の計算に使用する定数
# EXP_CONSTANT = 2
# ゴールドの計算に使用する定数
# GOLD_CONSTANT = 3

# GamesControllerクラスをインスタンス化
games_controller = GamesController.new

# brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
# monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

terry = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
slime = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

# GamesControllerクラスのbattleメソッドを使用
games_controller.battle(brave: terry, monster: slime)

# loop do
#   brave.attack(monster)
#   break if monster.hp <= 0

#   monster.attack(brave)
#   break if brave.hp <= 0
# end

# battle_result = brave.hp > 0

# if battle_result
#   exp = (monster.offense + monster.defense) * EXP_CONSTANT # 経験値の計算に使用する定数
#   gold = (monster.offense + monster.defense) * GOLD_CONSTANT # ゴールドの計算に使用する定数
#   puts "#{brave.name}はたたかいに勝った"
#   puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
# else
#   puts "#{brave.name}はたたかいに負けた"
#   puts "目の前が真っ暗になった"
# end