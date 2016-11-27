# Mastermind, a 4 pin sequence of 6 possible colors is layed out in a specific
# order.
# The player must guess the color and order, successful guesses are rewarded
# with white pegs: proper color on board, but incorrect location
# and black pegs: proper color on board in the proper location
# 12 turns, display board after each guess

# Engine
# -set_start
# -print_type
# -print_turn
# -print_win
# -print_loss

# Board - display, update, store values
# -print_board
# -set_code
# -set_hints
# -set_guess
# -update_board
# -check_status (:win/:loss)

# Player - name, ai
# -init_type
# -init_code
# -init_guess

# Turn one >> ABCE
#   -----------
# 1 | A B C E | bww
# 2 | o o o o |
# 3 | o o o o |
# 4 | o o o o |
# 5 | o o o o |
# 6 | o o o o |
# 7 | o o o o |
# 8 | o o o o |
# 9 | o o o o |
#10 | o o o o |
#11 | o o o o |
#12 | o o o o |
#   -----------

# Turn two >> ACDF
#   -----------
# 1 | A B C E | bww
# 2 | A C D F | bb
# 3 | o o o o |
# 4 | o o o o |
# 5 | o o o o |
# 6 | o o o o |
# 7 | o o o o |
# 8 | o o o o |
# 9 | o o o o |
#10 | o o o o |
#11 | o o o o |
#12 | o o o o |
#   -----------

require './mastermind/board.rb'
require './mastermind/player.rb'
require './mastermind/engine.rb'

engine = Engine.new
#engine.play

#p Board.print_board
