require 'minitest/autorun'
require 'keyes'
require 'mocha'
require 'pry'

class TestIpAddress < MiniTest::Unit::TestCase
  def setup
    @scorer = Keyes::Scorers::IpAddressScorer.new
    @scorer.stubs(:data).returns(test_data)
  end

  def test_required_param
    # raises for invalid param
    assert_raises ArgumentError do
      @scorer.score(ip_address: nil)
    end

    # doesn't raise for valid IP address
    @scorer.score(ip_address: '192.168.1.1')
  end

  def test_matched_address_score
    # given an IP address in the data #score returns the associated score
    assert_equal 40, @scorer.score(ip_address: '192.168.0.1')
  end

  def test_not_matched_address_score
    # given an IP address not in the data #score returns 0
    assert_equal 0, @scorer.score(ip_address: '203.63.10.1')
  end

  def test_matched_range_score
    # given an IP address within range of data #score returns associated score
    assert_equal 25, @scorer.score(ip_address: '110.10.10.49')
  end

  private
  def test_data
    {
      '10.0.0.1/8' => 80,
      '192.168.0.1' => 40,
      '41.58.0.0/16' => 90,
      '110.10.10.10 - 110.10.10.50' => 25
    }
  end
end
