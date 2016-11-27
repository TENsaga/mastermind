require "./lib/mastermind/engine.rb"
require "./lib/mastermind/board.rb"
require "./lib/mastermind/player.rb"
# require "test/unit"
require 'minitest/autorun'
# require 'minitest/pride'
require 'minitest/reporters'

# Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new]

Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class TestEngine < Minitest::Test
  def setup
    engine = Engine.new
    @board = Board.new
    @turn = 1
    @guess = "ABCD"
  end


  def test_player_setup

  end

end
