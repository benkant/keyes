require 'minitest/autorun'
require 'keyes'

class TestEngine < MiniTest::Unit::TestCase
  def setup
    @fd = Keyes::Engine.new
  end

  def test_initializes_scorers
    # TODO testing private methods?
    assert_instance_of Array, @fd.send(:scorers)
    assert_operator @fd.send(:scorers).count, :>, 0
  end

  def test_score_returns_highest
    params = mock
    scorer1 = mock
    scorer2 = mock

    scorer1.expects(:score).with(params).returns(13)
    scorer2.expects(:score).with(params).returns(26)

    @fd.expects(:check_params).with(params)
    @fd.expects(:scorers).returns([scorer1, scorer2])

    assert_equal 26, @fd.score(params)
  end

  private
  def required_parameters
    [:ip_address, :city, :region, :postal, :country]
  end
end
