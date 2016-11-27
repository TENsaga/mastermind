class Engine
  def initialize
    @turn = 1
    print_intro
    player_setup
    @board = Board.new(@player.type)
    determine_route
  end

  def determine_route
    if @player.type == "1"
      @intro_play = "\nHello Code Breaker: A random 4 digit code has been initialized... begin guessing\n\n"
    elsif @player.type == "2"
      @intro_play = "\nHello Code Setter: Please choose a 4 character code using only A-F\n\n"
    end
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
    puts "\nAlright #{name}, would you like to break the code (1), or be the coder (2)?"
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
