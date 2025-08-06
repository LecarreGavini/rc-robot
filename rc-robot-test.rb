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
end