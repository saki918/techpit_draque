# brave.rbとmonster.rbの両方に記述
require './character'

# Characterクラスを継承
class Brave < Character
  # class Brave
    # attr_reader :name, :offense, :defense
    # attr_accessor :hp
  
    SPECIAL_ATTACK_CONSTANT = 1.5
  
    # def initialize(**params)
    #   @name = params[:name]
    #   @hp = params[:hp]
    #   @offense = params[:offense]
    #   @defense = params[:defense]
    # end
  
    def attack(monster)
      # puts "#{@name}の攻撃"
  
      attack_type = decision_attack_type
      damage = calculate_damage(target: monster, attack_type: attack_type)
      cause_damage(target: monster, damage: damage)

      # attack_messageの呼び出し
      # attack_message
      # attack_typeを引数に渡す
      attack_message(attack_type: attack_type)
  
      # puts "#{monster.name}の残りHPは#{monster.hp}だ"
      # damage_messageを呼び出す
      damage_message(target: monster, damage: damage)
    end
  
    private
  
      def decision_attack_type
        attack_num = rand(4)
  
        if attack_num == 0
          # puts "必殺攻撃"
          "special_attack"
        else
          # puts "通常攻撃"
          "normal_attack"
        end
      end
  
      def calculate_damage(**params)
        target = params[:target]
        attack_type = params[:attack_type]
  
        if attack_type == "special_attack"
          calculate_special_attack - target.defense
        else
          @offense - target.defense
        end
      end
  
      def cause_damage(**params)
        damage = params[:damage]
        target = params[:target]
  
        target.hp -= damage
        target.hp = 0 if target.hp < 0
  
        # puts "#{target.name}は#{damage}のダメージを受けた"
      end
  
      def calculate_special_attack
        @offense * SPECIAL_ATTACK_CONSTANT
      end
  end