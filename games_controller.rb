# message_dialog.rbの読み込み
require './message_dialog'

class GamesController
  # MessageDialogモジュールのinclude
  include MessageDialog

  EXP_CONSTANT = 2
  GOLD_CONSTANT = 3

  # バトルの処理
  def battle(**params)
    # build_charactersを呼び出し インスタンス変数にparamsを代入しているので
    # メソッドの変数をインスタンス変数に書き換え
    build_characters(params)

    # 下のprivateのbuild_characterメソッドで呼び出し
    # brave = params[:brave]
    # monster = params[:monster]

    loop do
      @brave.attack(@monster)
      break if battle_end?
      @monster.attack(@brave)
      break if battle_end?
    end

    # battle_judgmentメソッドを呼び出す
    battle_judgment

    # 勇者の勝敗によってメッセージを変える
    # if battle_result
    #   result = calculate_of_exp_and_gold
    #   puts "#{@brave.name}はたたかいに勝った"
    #   puts "#{result[:exp]}の経験値と#{result[:gold]}ゴールドを獲得した"
    # else
    #   puts "#{@brave.name}はたたかいに負けた"
    #   puts "目の前が真っ暗になった"
    # end
  end

  # 以下のメソッドはクラス外から呼び出す必要がないのでprivate以下に記述する
  private
    # キャラクターのインスタンスをインスタンス変数に格納
    def build_characters(**params)
      @brave = params[:brave]
      @monster = params[:monster]
    end

    # バトル終了の判定
    def battle_end?
      # character.hp <= 0
      # 勇者かモンスター、どちらかのHPが0になったらバトルが終了する
      @brave.hp <= 0 || @monster.hp <= 0
    end

    # 勇者の勝利判定
    def brave_win?
      @brave.hp > 0
    end

    def battle_judgment
      # 勇者の勝敗によってメッセージを変える
      if brave_win?
        result = calculate_of_exp_and_gold
        # puts "#{@brave.name}はたたかいに勝った"
        # puts "#{result[:exp]}の経験値と#{result[:gold]}ゴールドを獲得した"
      else
        # puts "#{@brave.name}はたたかいに負けた"
        # puts "目の前が真っ暗になった"
      end
      # end_messageを呼び出す
      end_message(result)
    end

    # 経験値とゴールドの計算
    def calculate_of_exp_and_gold
      # exp = (@monster.offense + @monster.defense) * EXP_CONSTANT
      # gold = (@monster.offense + @monster.defense) * GOLD_CONSTANT
      # result = {exp: exp, gold: gold}

      # result
      
      if brave_win?
        brave_win_flag = true
        exp = (@monster.offense + @monster.defense) * EXP_CONSTANT
        gold = (@monster.offense + @monster.defense) * GOLD_CONSTANT
      else
        brave_win_flag = false
        exp = 0
        gold = 0
      end

      {brave_win_flag: brave_win_flag, exp: exp, gold: gold}
    end

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
end