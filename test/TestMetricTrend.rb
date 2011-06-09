require 'test/unit'
require 'Log'
require 'MetricTrend'

class TestMetricTrend < Test::Unit::TestCase
  def setup
    @logger = Log.getLogger()
  end

  def test_week
    expected = Hash.new

    5.times { |week| expected[Date.new(2011, 5 ,2+week*7)] = nil}

    mt = MetricTrend.new('2011-05-01','2011-05-31','com.baxter.pe:price-engine','coverage',MetricTrend::WEEK)

    difference = (mt.days.keys - expected.keys) | (expected.keys - mt.days.keys)

    @logger.debug("Expected dates: [#{expected.keys.join("; ")}]")
    @logger.debug("Actual dates  : [#{mt.days.keys.join("; ")}]")
    @logger.debug("Difference    : [#{difference.join("; ")}]")

    assert_equal(0,difference.length,"Day numbers different")
  end

  def test_workday
    expected = Hash.new

    4.times {|week|  5.times { |day|  expected[Date.new(2011, 5 ,2+week*7+day)] = nil } }

    mt = MetricTrend.new('2011-05-01','2011-05-29','com.baxter.pe:price-engine','coverage',MetricTrend::WORKDAY)

    difference = (mt.days.keys - expected.keys) | (expected.keys - mt.days.keys)

    @logger.debug("Expected dates: [#{expected.keys.join("; ")}]")
    @logger.debug("Actual dates  : [#{mt.days.keys.join("; ")}]")
    @logger.debug("Difference    : [#{difference.join("; ")}]")

    assert_equal(0,difference.length,"Day numbers different")
  end

end