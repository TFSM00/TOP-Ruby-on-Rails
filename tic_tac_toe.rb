# This plays a tic-tac-toe game

class TicTacToe

  @board = {1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9}
  @winner = ""
  @play = ""
  @choice = ""
  @bot = ""


  def initialize
    puts ""
    puts "Do you want to play as X or O? "
    @choice = gets.chomp 
    @choice == "X" ? @bot = "O" : @bot = "X"

    puts "\e[H\e[2J"
    if @choice == "X"
      print_board
      puts "Select a position by entering the corresponding number: "
      @play = gets.chomp
      until moves_left.include? (@play.to_i)
        puts "Select a position by entering the corresponding number: "
        @play = gets.chomp
      end
      puts "\e[H\e[2J"
      @board[@play.to_i] = @choice
    end

    while !has_ended?
      bot_play
      if has_ended? == true
        break
      end
      print_board
      puts ""
      @play = ""
      puts "Select a position by entering the corresponding number: "
      @play = gets.chomp
      until moves_left.include? (@play.to_i)
        puts "Select a position by entering the corresponding number: "
        @play = gets.chomp
      end
      puts "\e[H\e[2J"
      @board[@play.to_i] = @choice
    end

    puts "\e[H\e[2J"
    print_board
    puts ""

    if has_ended? && @winner == @choice
      puts "Congrats, you have won!"
    elsif has_ended? && @winner == @bot
      puts "Oops, the computer has won!"
    else
      puts "Oh well, it's a tie!"
    end
  end

  def print_board
    puts ""
    puts " #{@board[1]} | #{@board[2]} | #{@board[3]} "
    puts "-----------"
    puts " #{@board[4]} | #{@board[5]} | #{@board[6]} "
    puts "-----------"
    puts " #{@board[7]} | #{@board[8]} | #{@board[9]}"
    puts ""
  end

  private
  # def clear_board
  #   @board = {1=>"1", 2=>"2", 3=>"3", 4=>"4", 5=>"5", 6=>"6", 7=>"7", 8=>8, 9=>9}
  # end

  def has_ended?
    winning_positions = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    winning_positions.each do |i|
      row = @board[i[0]].to_s + @board[i[1]].to_s + @board[i[2]].to_s
      if row == "XXX"
        @winner = "X"
        return true
      elsif row == "OOO"
        @winner = "O"
        return true
      end
    end

    if @board.values.any? { |value| value.to_i.between?(1,9) }
      return false
    else
      return true
    end

  end

  def moves_left
    values = @board.values
    movesleft = values.select { |value| value.is_a? Integer}
    return movesleft
  end

  def make_play(pos, choice)
    @board[pos] = choice
  end

  def bot_play
    @board[moves_left.sample.to_i] = @bot
  end
end

board = TicTacToe.new()
#board.print_board