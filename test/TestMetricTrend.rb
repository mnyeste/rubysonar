require 'test/unit'
require 'Log'
require 'MetricTrend'

class TestMetricTrend < Test::Unit::TestCase
  def setup
    @logger = Log.getLogger()
  end

  def test_week
    expected = Array.new

    5.times { |week| expected<<Date.new(2011, 5 ,2+week*7)}

    mt = MetricTrend.new('2011-05-01','2011-05-31','com.baxter.pe:price-engine','coverage',MetricTrend::WEEK)

    difference = (mt.days - expected) | (expected - mt.days)

    @logger.debug("Expected dates: [#{expected.join("; ")}]")
    @logger.debug("Actual dates  : [#{smt.days.join("; ")}]")
    @logger.debug("Difference    : [#{difference.join("; ")}]")

    assert_equal(0,difference.length,"Day numbers different")
  end

  def test_workday
    expected = Array.new

    4.times {|week|  5.times { |day|  expected<<Date.new(2011, 5 ,2+week*7+day) } }

    mt = MetricTrend.new('2011-05-01','2011-05-29','com.baxter.pe:price-engine','coverage',MetricTrend::WORKDAY)

    difference = (mt.days - expected) | (expected - mt.days)

    @logger.debug("Expected dates: [#{expected.join("; ")}]")
    @logger.debug("Actual dates  : [#{mt.days.join("; ")}]")
    @logger.debug("Difference    : [#{difference.join("; ")}]")

    assert_equal(0,difference.length,"Day numbers different")
  end

end