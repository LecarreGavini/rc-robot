require 'minitest/autorun'
require_relative 'rc-robot'

class RcRobotTest < Minitest::Test
  def setup
    $direction = nil
    $position = [0, 0]
  end

  def test_listen_quit
    assert_equal false, listen_quit('test')
    assert_equal true, listen_quit('q')
    assert_equal true, listen_quit('Q')
  end
  def test_listen_invalid_command
    assert_equal false, listen_invalid_command('MOVE')
    assert_equal false, listen_invalid_command('LEFT')
    assert_equal false, listen_invalid_command('RIGHT')
    assert_equal false, listen_invalid_command('REPORT')
    assert_equal false, listen_invalid_command('PLACE')
    assert_equal false, listen_invalid_command('PLACE 123')
    assert_equal false, listen_invalid_command('PLACE 0,0')
    assert_equal false, listen_invalid_command('PLACER')
    assert_equal true, listen_invalid_command('PLAC')
    assert_equal true, listen_invalid_command('MOV')
    assert_equal true, listen_invalid_command('move')
    assert_equal true, listen_invalid_command('left')
    assert_equal true, listen_invalid_command('right')
    assert_equal true, listen_invalid_command('report')
    assert_equal true, listen_invalid_command('place')
  end
  def test_listen_commands_before_place
    assert_equal true, listen_commands_before_place('MOVE')
    assert_equal true, listen_commands_before_place('LEFT')
    assert_equal true, listen_commands_before_place('RIGHT')
    assert_equal true, listen_commands_before_place('REPORT')
    assert_equal false, listen_commands_before_place('random')
    assert_equal false, listen_commands_before_place('PLACE')
    assert_equal false, listen_commands_before_place('place')
    $direction = $NORTH
    assert_equal false, listen_commands_before_place('MOVE')
    assert_equal false, listen_commands_before_place('LEFT')
    assert_equal false, listen_commands_before_place('RIGHT')
    assert_equal false, listen_commands_before_place('REPORT')
  end
  def test_listen_invalid_place_command
    assert_equal true, listen_invalid_place_command('PLACEE')
    assert_equal true, listen_invalid_place_command('PLACE 0,0 NORTHWEST')
    assert_equal true, listen_invalid_place_command('PLACE NORTH')
    assert_equal true, listen_invalid_place_command('PLACE a,b NORTH')
    assert_equal true, listen_invalid_place_command('PLACE -1,0 NORTH')
    assert_equal true, listen_invalid_place_command('PLACE 5,0 NORTH')
    assert_equal true, listen_invalid_place_command('PLACE 0,-1 NORTH')
    assert_equal true, listen_invalid_place_command('PLACE 0,5 NORTH')
    assert_equal false, listen_invalid_place_command('PLACE 1,0 NORTH')
  end
  def test_set_direction_and_position
    set_direction_and_position('PLACE 1,0 NORTH')
    assert_equal true, $direction == $NORTH
    assert_equal true, $position[0] == 1
    assert_equal true, $position[1] == 0
    set_direction_and_position('PLACE 4,2 SOUTH')
    assert_equal true, $direction == $SOUTH
    assert_equal true, $position[0] == 4
    assert_equal true, $position[1] == 2
    set_direction_and_position('PLACE 1,3 EAST')
    assert_equal true, $direction == $EAST
    assert_equal true, $position[0] == 1
    assert_equal true, $position[1] == 3
    set_direction_and_position('PLACE 3,2 WEST')
    assert_equal true, $direction == $WEST
    assert_equal true, $position[0] == 3
    assert_equal true, $position[1] == 2
  end
  def test_set_direction
    $direction = $NORTH
    set_direction('LEFT')
    assert_equal true, $direction == $WEST
    set_direction('LEFT')
    assert_equal true, $direction == $SOUTH
    set_direction('LEFT')
    assert_equal true, $direction == $EAST
    set_direction('RIGHT')
    assert_equal true, $direction == $SOUTH
    set_direction('RIGHT')
    assert_equal true, $direction == $WEST
    set_direction('RIGHT')
    assert_equal true, $direction == $NORTH
    set_direction('RIGHT')
    assert_equal true, $direction == $EAST
  end
  def test_move_position
    $direction = $NORTH
    $position[0] = 0
    $position[1] = 0
    move_position()
    assert_equal true, $position[0] == 0
    assert_equal true, $position[1] == 1
    move_position()
    assert_equal true, $position[0] == 0
    assert_equal true, $position[1] == 2
    $direction = $WEST
    move_position()
    assert_equal true, $position[0] == 0
    assert_equal true, $position[1] == 2
    $direction = $EAST
    move_position()
    move_position()
    move_position()
    assert_equal true, $position[0] == 3
    assert_equal true, $position[1] == 2
    $direction = $SOUTH
    move_position()
    assert_equal true, $position[0] == 3
    assert_equal true, $position[1] == 1
    $direction = $NORTH
    move_position()
    move_position()
    move_position()
    move_position()
    move_position()
    assert_equal true, $position[0] == 3
    assert_equal true, $position[1] == 4
  end
end