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
    end
    @hints.split("").shuffle.sort.join
  end

  def check_status(guess)
    guess == @code ? true : false
  end
end
