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

class TestPlayer < Minitest::Test
  def setup
    player = Player.new("Joe")
  end

  def test_simple
    assert true
  end

  #def test_player_setup

  #end

end
