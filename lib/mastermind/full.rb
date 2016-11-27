#require './board.rb'
#require './player.rb'
# Engine
# -play
# -print_type
# -print_turn
# -print_win
# -print_loss


# Player - name, ai
# -init_type
# -init_code
# -init_guess

class Player
  attr_reader :name, :type

  def initialize(name, type = 1)
    @name = name
    @type = type
  end
end

# Board - display, update, store values
# -print_board
# -code=
# -set_guess
# -set_hints
# -check_status (:win/:loss)

# Turn one >> ABCE
#   ~~~~~~~~~~~
# 1 | A B C E | bwww
# 2 | o o o o | -bww
# 3 | o o o o | ---w
# 4 | o o o o |
# 5 | o o o o |
# 6 | o o o o |
# 7 | o o o o |
# 8 | o o o o |
# 9 | o o o o |
#10 | o o o o |
#11 | o o o o |
#12 | o o o o |
#   ~~~~~~~~~~~

# 1 | A B C E | bwww   <19
class Board
  attr_accessor :board, :ai_lock, :ai_white
  attr_accessor :code

  def initialize(type)
    @board = []
    @code = Array.new(4) { ('A'..'F').to_a[rand(6)] }.join unless type == 2
    @hints = Array.new(12) { '----' }
    @field = Array.new(12) { 'o o o o' }
    @turn = Array.new(12) { |i| i < 9 ? " #{i + 1}" : (i + 1).to_s }

    @board << '   ~~~~~~~~~~~'
    12.times { |i| @board << @turn[i] + " | " + @field[i] + " | " + @hints[i] }
    @board << '   ~~~~~~~~~~~'
  end

  def print_board
    @board.each { |i| puts i }
  end

  def set_field(turn, guess)
    guess.each_char { |x| @board[turn].sub!(/o/, x) }
    set_hints(turn, guess)
  end

  def set_hints(turn, guess)
    @code_check = String.new(@code)
    @hints = ""
    @ai_lock ||= Array.new(4)
    @ai_white ||= Array.new(4)

    black_pegs(guess)
    white_pegs(guess)
    @hints.each_char { |x| @board[turn].sub!(/-/, x) }
  end

  def black_pegs(guess)
    4.times do |ind|
      if @code_check[ind] == guess[ind]
        @hints += "b"
        @ai_lock[ind] = guess[ind]
        @code_check[ind] = guess[ind] = " "
      end
    end
  end

  def white_pegs(guess)
    guess.delete(' ').each_char do |char|
      @hints += "w" if @code_check.include? char
      #@ai_white = char if @code_check.include? char
    end
    @hints.split("").shuffle.sort.join
  end

  def check_status(guess)
    guess == @code ? true : false
  end
end


# print board.board
# p board.board[0]
# board.print_board


#board = Board.new(2)

#board.code = "ADFC"
#board.set_field(1, "AFCC")
#p board.board[1]

# pboard.ai_lock

# Array.new(4) { ('A'..'F').to_a[rand(6)] }.join

# assert_equal("bww", @board.set_hints(@turn, "AECF")

# board.code = "ADFC"
# board.set_field(1, "AECF")
# board.set_hints(1, "AECF")
# board.set_field(2, "AECC")
# board.set_hints(2, "AECC")

# board.print_board

#p board.check_status("BBBB")



class Engine
  def initialize
    @turn = 1
    print_intro
    player_setup
    @board = Board.new(@player.type)
    determine_route

    #@board = Board.new("2")
    #play_code_setter
  end

  def determine_route
    if @player.type == "1"
      @intro_play = "\nHello Code Breaker: A random 4 digit code has been initialized... begin guessing\n\n"
    elsif @player.type == "2"
      @intro_play = "\nHello Code Setter: Please choose a 4 character code using only A-F\n\n"
    end


    # if @player.type == "1"
    #   play_code_breaker
    # elsif @player.type == "2"
    #   play_code_setter
    # end

    play
  end

  def play
    puts @intro_play
    set_code if @player.type == "2"
    turn
    puts "\n...The code remains unsolved...\n"
  end

  def turn
    while @turn < 13
      if @player.type == "1"
        @guess = String.new(set_guess)
      elsif @player.type == "2"
        puts "\nReady for computation?(enter)\n"
        $stdin.gets.chomp
        @guess = String.new(set_computer_guess)
      end
      return print_win if @board.check_status(@guess)
      update_board
      @turn += 1
    end
  end

  def set_code
    begin
      print ">"
      code = $stdin.gets.chomp
      check_input_error(code)
    rescue RuntimeError => e
      print e
      retry
    end
    @board.code = code
  end

  def update_board
    @board.set_field(@turn, @guess)
    @board.print_board
  end

  def check_input_error(guess)
  raise "\t\n Input Error: Please enter 4 characters
              between A and F\n\n" unless guess.length == 4 && guess !~ /[^A-F]/
  end

  def set_computer_guess
    puts "\nTurn : #{@turn}"
    puts "The computer guesses:"
    if @turn == 1
      @guess = Array.new(4) { ('A'..'F').to_a[rand(6)] }.join
      # Testing
      # guess = "ABCE"
    else
      @guess = computer_logic
    end

    print "\n>#{@guess}\n\n"
    @guess
  end

  def computer_logic
    new_guess = Array.new(@board.ai_lock)
    new_guess.map! do |x|
      if x.nil?
        ('A'..'F').to_a[rand(6)]
      else
        x
      end
    end
    new_guess.join
  end

  def set_guess
    begin
      puts "Turn : #{@turn}"
      puts "What is your guess?"
      print ">"
      guess = $stdin.gets.chomp
      check_input_error(guess)
    rescue RuntimeError => e
      print e
      retry
    end
    guess
  end

  def player_setup
    puts "Player, what is your name?"
    print ">"
    name = $stdin.gets.chomp
    puts "Alright #{name}, would you like to break the code (1), or be the coder (2)?"
    print ">"
    type = $stdin.gets.chomp
    @player = Player.new(name, type)
  end

  def print_intro
    puts "Welcome to Mastermind!"
  end

  def print_win
    update_board
    if @player.type == "1"
      puts "\nCongradulations #{@player.name}, you win!\n\n"
    else
      puts "\nBbbZffrzzttt.. #{@player.name} has fallen to the computer\n\n"
    end
    @board.print_board
    exit
  end
end

#@board = Board.new
#@player = Player.new("Joe")
e = Engine.new


#p @board.check_status("BBBB")

#e.play
