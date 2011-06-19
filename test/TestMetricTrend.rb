require 'test/unit'
require 'Log'
require 'MetricTrend'
require 'TimeMachineData'

class TestMetricTrend < Test::Unit::TestCase
  def setup
    @logger = Log.getLogger()
  end

  def test_week
    expected = Hash.new

    5.times { |week| expected[Date.new(2011, 5 ,2+week*7)] = nil}

    mt = MetricTrend.new('2011-05-01','2011-05-31','com.baxter.pe:price-engine','coverage',MetricTrend::WEEK)

    difference = (mt.trend.keys - expected.keys) | (expected.keys - mt.trend.keys)

    @logger.debug("Expected dates: [#{expected.keys.join("; ")}]")
    @logger.debug("Actual dates  : [#{mt.trend.keys.join("; ")}]")
    @logger.debug("Difference    : [#{difference.join("; ")}]")

    assert_equal(0,difference.length,"Day numbers different")
  end

  def test_workday

    expected = Hash.new

    4.times {|week|  5.times { |day|  expected[Date.new(2011, 5 ,2+week*7+day)] = nil } }

    mt = MetricTrend.new('2011-05-01','2011-05-29','com.baxter.pe:price-engine','coverage',MetricTrend::WORKDAY)

    difference = (mt.trend.keys - expected.keys) | (expected.keys - mt.trend.keys)

    @logger.debug("Expected dates: [#{expected.keys.join("; ")}]")
    @logger.debug("Actual dates  : [#{mt.trend.keys.join("; ")}]")
    @logger.debug("Difference    : [#{difference.join("; ")}]")

    assert_equal(0,difference.length,"Day numbers different")
  end

  def test_merge

    response =  [["date", "coverage"],
      ["2011-05-04T02:05:35+0200", "16.1"],
      ["2011-05-16T02:09:13+0200", "17.3"],
      ["2011-05-26T17:10:56+0200", "18.6"]]

    expected = {
      Date.strptime("2011-04-25", '%Y-%m-%d') => nil,
      Date.strptime("2011-05-02", '%Y-%m-%d') => nil,
      Date.strptime("2011-05-09", '%Y-%m-%d') => 16.1,
      Date.strptime("2011-05-16", '%Y-%m-%d') => 17.3,
      Date.strptime("2011-05-23", '%Y-%m-%d') => 17.3,
      Date.strptime("2011-05-30", '%Y-%m-%d') => 18.6,
      Date.strptime("2011-06-06", '%Y-%m-%d') => nil
    }

    mt = MetricTrend.new('2011-04-25','2011-06-10','com.baxter.pe:price-engine','coverage',MetricTrend::WEEK)
    mt.merge(TimeMachineData.new(response).data,  Date.strptime("2011-06-04", '%Y-%m-%d'))
    assert_equal(expected,mt.trend,"Merged data is different than expected" )

  end

  def test_merge_no_data
    response =  [["date", "coverage"]]

    expected = {
      Date.strptime("2011-04-25", '%Y-%m-%d') => nil,
      Date.strptime("2011-05-02", '%Y-%m-%d') => nil,
      Date.strptime("2011-05-09", '%Y-%m-%d') => nil,
      Date.strptime("2011-05-16", '%Y-%m-%d') => nil,
      Date.strptime("2011-05-23", '%Y-%m-%d') => nil,
      Date.strptime("2011-05-30", '%Y-%m-%d') => nil,
      Date.strptime("2011-06-06", '%Y-%m-%d') => nil
    }

    mt = MetricTrend.new('2011-04-25','2011-06-10','com.baxter.pe:price-engine','coverage',MetricTrend::WEEK)
    mt.merge(TimeMachineData.new(response).data,  Date.strptime("2011-06-04", '%Y-%m-%d'))
    assert_equal(expected,mt.trend,"Merged data is different than expected" )

  end
  
  
def test_merge_more_data

    response =  [["date", "coverage"],
      ["2011-05-10T02:05:35+0200", "16.1"],
      ["2011-05-11T02:09:13+0200", "17.3"],
      ["2011-05-12T17:10:56+0200", "18.6"]]

    expected = {
      Date.strptime("2011-05-09", '%Y-%m-%d') => nil,
      Date.strptime("2011-05-16", '%Y-%m-%d') => 18.6,
      Date.strptime("2011-05-23", '%Y-%m-%d') => 18.6
    }

    mt = MetricTrend.new('2011-05-09','2011-05-23','com.baxter.pe:price-engine','coverage',MetricTrend::WEEK)
    mt.merge(TimeMachineData.new(response).data,  Date.strptime("2011-06-04", '%Y-%m-%d'))
    assert_equal(expected,mt.trend,"Merged data is different than expected" )

  end

  
end