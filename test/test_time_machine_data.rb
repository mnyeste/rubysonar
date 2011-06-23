require 'test/unit'
require 'date'
require 'fakeweb'
require 'csv'
require 'time_machine_data'

class TestTimeMachineData < Test::Unit::TestCase

  FAKE_SERVER="http://localhost"
  def fake_response(response)
    FakeWeb.register_uri(:post, "#{FAKE_SERVER}/api/timemachine", :body => response.join("\n"))
  end

  def teardown
    FakeWeb.clean_registry()
  end

  def test_parse

    expected = {
      Date.strptime("2011-05-25", '%Y-%m-%d') => 16.1,
      Date.strptime("2011-05-26", '%Y-%m-%d') => 16.6,
      Date.strptime("2011-05-27", '%Y-%m-%d') => 16.7,
      Date.strptime("2011-05-31", '%Y-%m-%d') => 17.4,
      Date.strptime("2011-06-02", '%Y-%m-%d') => 17.7
    }

    fake_response(["date,coverage",
      "2011-05-25T02:05:35+0200,16.1",
      "2011-05-26T02:09:13+0200,16.3",
      "2011-05-26T17:10:56+0200,16.6",
      "2011-05-27T16:08:25+0200,16.7",
      "2011-05-27T02:06:22+0200,16.5",
      "2011-05-31T10:50:59+0200,17.2",
      "2011-05-31T18:36:53+0200,17.4",
      "2011-05-31T02:06:36+0200,17.3",
      "2011-06-02T02:04:59+0200,17.5",
      "2011-06-02T12:05:25+0200,17.6",
      "2011-06-02T22:07:53+0200,17.7"])

    tmd = TimeMachineData.new(FAKE_SERVER, "com.baxter.pe:price-engine","coverage")

    assert_equal(expected,tmd.data,"Parsed data don't match expected")

  end

  def test_parse_more_data_one_day
    expected = {
      Date.strptime("2011-05-28", '%Y-%m-%d') => 16.1,
      Date.strptime("2011-05-29", '%Y-%m-%d') => 16.6,
      Date.strptime("2011-05-30", '%Y-%m-%d') => 16.7,
    }

    fake_response(["date,coverage",
      "2011-05-28T02:05:35+0200,16.1",
      "2011-05-29T02:09:13+0200,16.3",
      "2011-05-29T17:10:56+0200,16.6",
      "2011-05-30T16:08:25+0200,16.7",
      "2011-05-30T02:06:22+0200,16.5",
      "2011-05-30T10:50:59+0200,17.2",
    ])

    tmd = TimeMachineData.new(FAKE_SERVER, "com.baxter.pe:price-engine","coverage")

    assert_equal(expected,tmd.data,"Parsed data don't match expected")

  end

  def test_parse_empty

    fake_response(["date,coverage"])

    tmd = TimeMachineData.new(FAKE_SERVER, "com.baxter.pe:price-engine","coverage")

    assert_equal({},tmd.data,"Parsed data don't match expected")

  end

end