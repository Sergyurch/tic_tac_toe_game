class Game
  def initialize
    puts 'Would you like to play?'
    puts 'This is THE TIC TAC TOE Game'
    puts 'Two players are needed to play the game'
    puts 'Enter the name of Player1:'
    @player1 = Player.new(gets.chomp)
    @current_turn = @player1
    puts "Hi, #{@player1.name}. You will be playing with \"X\""
    @player1.sign = 'X'
    puts 'Enter the name of Player2:'
    @player2 = Player.new(gets.chomp)
    puts "Hi, #{@player2.name}. You will be playing with \"0\""
    @player2.sign = '0'
    @board = Board.new
    puts "Lets start to play"
  end
  
  def start
    9.times do
      @board.layout
      puts "#{@current_turn.name}, make you choice using the board layout"
      current_choice = gets.chomp.to_i
      until current_choice.to_s.match?(/[1-9]/) && @board.cells[current_choice - 1] == " " do
        puts "You entered a wrong symbol or this cell is allready filled"
        current_choice = gets.chomp.to_i
      end
      @board.cells[current_choice - 1] = @current_turn.sign
      @board.show
      if finish?(@current_turn)
        puts "#{@current_turn.name} won the game!"
        @current_turn = (@current_turn == @player1) ? @player2: @player1
        play_again?
        return
      end
      @current_turn = (@current_turn == @player1) ? @player2: @player1
    end
    
    puts "Draw!"
    play_again?
    return
  end
  
  private
  
  def finish?(player)
    if @board.cells[0] == player.sign && @board.cells[1] == player.sign && @board.cells[2] == player.sign ||
       @board.cells[3] == player.sign && @board.cells[4] == player.sign && @board.cells[5] == player.sign ||
       @board.cells[6] == player.sign && @board.cells[7] == player.sign && @board.cells[8] == player.sign ||
       @board.cells[0] == player.sign && @board.cells[3] == player.sign && @board.cells[6] == player.sign ||
       @board.cells[1] == player.sign && @board.cells[4] == player.sign && @board.cells[7] == player.sign ||
       @board.cells[2] == player.sign && @board.cells[5] == player.sign && @board.cells[8] == player.sign ||
       @board.cells[0] == player.sign && @board.cells[4] == player.sign && @board.cells[8] == player.sign ||
       @board.cells[2] == player.sign && @board.cells[4] == player.sign && @board.cells[6] == player.sign 
      return true
    end
  end
  
  def play_again?
    puts "Would you like to play again (Y/N)?"
    answer = gets.chomp
    until answer.match?(/[Y,y,N,n]/) do
      puts "Use only Y or N. Would you like to play again (Y/N)?"
      answer = gets.chomp
    end
    if answer.match?(/[Y,y]/)
      @board = Board.new
      self.start
    end
  end
  
end

class Player
  attr_accessor :name, :sign
  def initialize(name)
    @name = name
    @sign
  end
end

class Board
  attr_accessor :cells
  def initialize
    @cells = []
    9.times {@cells.push(' ')}
  end

  def layout
    puts "This is a layout of the game board"
    puts "You should use digits from 1 to 9 to make your choice during the game"
    puts "---------"
    puts "1 | 2 | 3"
    puts "---------"
    puts "4 | 5 | 6"
    puts "---------"
    puts "7 | 8 | 9"
    puts "---------"
  end
  
  def show
    puts "Current game board"
    puts "---------"
    puts "#{cells[0]} | #{cells[1]} | #{cells[2]}"
    puts "---------"
    puts "#{cells[3]} | #{cells[4]} | #{cells[5]}"
    puts "---------"
    puts "#{cells[6]} | #{cells[7]} | #{cells[8]}"
    puts "---------"
  end
end

game = Game.new
game.start
