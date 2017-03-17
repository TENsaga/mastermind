require "./lib/mastermind/board.rb"
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class TestBoard < Minitest::Test
  def setup
    @board = Board.new
    @turn = 1
  end

  def test_print_board
    b = <<GO
   ~~~~~~~~~~~
 1 | o o o o | ----
 2 | o o o o | ----
 3 | o o o o | ----
 4 | o o o o | ----
 5 | o o o o | ----
 6 | o o o o | ----
 7 | o o o o | ----
 8 | o o o o | ----
 9 | o o o o | ----
10 | o o o o | ----
11 | o o o o | ----
12 | o o o o | ----
   ~~~~~~~~~~~
GO
    empty = Board.new
    assert_output(b) { empty.print_board }
  end

  def test_set_code
    code = "ABDE"
    @board.code = code
    assert_equal(code, @board.code)
  end

  def test_set_field
    @board.code = "EEEE"
    @board.set_field(1, "ABCF")
    assert_output(" 1 | A B C F | ----") { print @board.board[1] }
  end

  def test_set_hints
    @board.code = "ADFC"

    assert_equal("bbbb", @board.set_hints(@turn, "ADFC"))
    assert_equal("w", @board.set_hints(@turn, "FEEE"))
  end

  def test_set_hints_board_output
    @board.code = "ADFC"

    assert_equal("bww", @board.set_field(@turn, "AECF"))
    assert_output(" 1 | A E C F | bww-") { print @board.board[1] }
  end

  def test_check_status
    @board.code = "ADFC"
    guess_fail = "ABCF"
    guess_true = "ADFC"

    assert_equal(false, @board.check_status(guess_fail))
    assert_equal(true, @board.check_status(guess_true))
  end
end
