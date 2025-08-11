require 'minitest/autorun'
require_relative 'v2.rc-robot'

class RcRobotTest < Minitest::Test
  def setup
    @robot = Robot.new
  end

  def test_valid_place
    @robot.place(0, 0, 'NORTH')
    assert_equal '0,0,NORTH', @robot.report
    @robot.place(1, 2, 'WEST')
    assert_equal '1,2,WEST', @robot.report
    @robot.place(3, 4, 'EAST')
    assert_equal '3,4,EAST', @robot.report
    @robot.place(4, 1, 'SOUTH')
    assert_equal '4,1,SOUTH', @robot.report
  end

  def test_invalid_place
    @robot.place(0, 0, 'NORTH')
    assert_equal '0,0,NORTH', @robot.report
    @robot.place(5, 2, 'WEST')
    assert_equal '0,0,NORTH', @robot.report
    @robot.place(3, 5, 'EAST')
    assert_equal '0,0,NORTH', @robot.report
    @robot.place(4, 1, 'EASTERN')
    assert_equal '0,0,NORTH', @robot.report
  end

  def test_valid_move
    @robot.place(0, 0, 'NORTH')
    @robot.move
    assert_equal '0,1,NORTH', @robot.report
    @robot.place(1, 2, 'WEST')
    @robot.move
    assert_equal '0,2,WEST', @robot.report
    @robot.place(3, 3, 'EAST')
    @robot.move
    assert_equal '4,3,EAST', @robot.report
    @robot.place(4, 1, 'SOUTH')
    @robot.move
    assert_equal '4,0,SOUTH', @robot.report
  end

  def test_invalid_move
    @robot.place(0, 4, 'NORTH')
    @robot.move
    assert_equal '0,4,NORTH', @robot.report
    @robot.place(0, 2, 'WEST')
    @robot.move
    assert_equal '0,2,WEST', @robot.report
    @robot.place(4, 3, 'EAST')
    @robot.move
    assert_equal '4,3,EAST', @robot.report
    @robot.place(4, 0, 'SOUTH')
    @robot.move
    assert_equal '4,0,SOUTH', @robot.report
  end

  def test_turn
    @robot.place(0, 0, 'NORTH')
    @robot.turn('LEFT')
    assert_equal '0,0,WEST', @robot.report
    @robot.turn('LEFT')
    assert_equal '0,0,SOUTH', @robot.report
    @robot.turn('LEFT')
    assert_equal '0,0,EAST', @robot.report
    @robot.turn('RIGHT')
    assert_equal '0,0,SOUTH', @robot.report
    @robot.turn('RIGHT')
    assert_equal '0,0,WEST', @robot.report
    @robot.turn('RIGHT')
    assert_equal '0,0,NORTH', @robot.report
  end

  def test_invalid
    assert @robot.invalid?('MOVE')
    assert @robot.invalid?('LEFT')
    assert @robot.invalid?('RIGHT')
    assert @robot.invalid?('REPORT')
    refute @robot.invalid?('PLACE')
    @robot.place(0, 0, 'NORTH')
    refute @robot.invalid?('MOVE')
    refute @robot.invalid?('LEFT')
    refute @robot.invalid?('RIGHT')
    refute @robot.invalid?('REPORT')
  end
end