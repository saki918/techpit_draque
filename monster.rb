# brave.rbとmonster.rbの両方に記述
require './character'

# Characterクラスを継承
class Monster < Character
  # class Monster
    # attr_reader :offense, :defense
    # attr_accessor :hp, :name

  POWER_UP_RATE = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    # @name = params[:name]
    # @hp = params[:hp]
    # @offense = params[:offense]
    # @defense = params[:defense]

    # キャラクタークラスのinitializeメソッドに処理を渡す
    # 通常のメソッドと同様に引数を渡すことができる
    super(
      name: params[:name],
      hp: params[:hp],
      offense: params[:offense],
      defense: params[:defense]
    )

    @transform_flag = false
    @trigger_of_transform = params[:hp] * CALC_HALF_HP
  end

  def attack(brave)
    if @hp <= @trigger_of_transform && @transform_flag == false

      @transform_flag = true
      transform
    end

    # puts "#{@name}の攻撃"

    damage = calculate_damage(brave)
    cause_damage(target: brave, damage: damage)

    # attack_messageの呼び出し
    attack_message

    # puts "#{brave.name}の残りHPは#{brave.hp}だ"
    # damage_messageを呼び出す
    damage_message(target: brave, damage: damage)
  end

  private

    def calculate_damage(target)
      @offense - target.defense
    end

    def cause_damage(**params)
      damage = params[:damage]
      target = params[:target]

      target.hp -= damage

      # もしターゲットのHPがマイナスになるなら0を代入
      target.hp = 0 if target.hp < 0

      # puts "#{target.name}は#{damage}のダメージを受けた"
    end

    def transform
      transform_name = "ドラゴン"

      # transform_messageを呼び出し
      transform_message(origin_name: @name, transform_name: transform_name)

      # puts <<~EOS
      # #{@name}は怒っている
      # #{@name}は#{transform_name}に変身した
      # EOS

      @offense *= POWER_UP_RATE
      @name = transform_name
    end
end