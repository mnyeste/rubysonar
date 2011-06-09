
require 'test/unit'
require 'date'
require 'Log'
require 'TimeMachineData'

class TestTimeMachineData < Test::Unit::TestCase
  def setup
    @logger = Log.getLogger()
  end

  def testparse
      testresponse =
          [["date", "coverage"],
           ["2011-05-25T02:05:35+0200", "16.5"],
           ["2011-05-26T02:09:13+0200", "16.5"],
           ["2011-05-27T02:06:22+0200", "16.5"],
           ["2011-05-27T17:09:56+0200", "16.5"],
           ["2011-05-30T12:01:48+0200", "17.2"],
           ["2011-05-31T02:06:36+0200", "17.2"],
           ["2011-05-31T10:50:59+0200", "17.2"],
           ["2011-05-31T18:36:53+0200", "17.1"],
           ["2011-06-02T02:04:59+0200", "17.1"],
           ["2011-06-03T02:05:25+0200", "17.1"],
           ["2011-06-04T02:07:53+0200", "17.1"],
           ["2011-06-06T13:19:12+0200", "17.5"],
           ["2011-06-07T02:07:31+0200", "17.7"],
           ["2011-06-08T02:07:59+0200", "17.7"],
           ["2011-06-09T02:05:35+0200", "17.8"]]                    

      expected = {
          Date.strptime("2011-05-25", '%Y-%m-%d') => 16.5,
          Date.strptime("2011-05-26", '%Y-%m-%d') => 16.5,
          Date.strptime("2011-05-27", '%Y-%m-%d') => 16.5,
          Date.strptime("2011-05-30", '%Y-%m-%d') => 17.2,
          Date.strptime("2011-05-31", '%Y-%m-%d') => 17.1,
          Date.strptime("2011-06-02", '%Y-%m-%d') => 17.1,
          Date.strptime("2011-06-03", '%Y-%m-%d') => 17.1,
          Date.strptime("2011-06-04", '%Y-%m-%d') => 17.1,
          Date.strptime("2011-06-06", '%Y-%m-%d') => 17.5,
          Date.strptime("2011-06-07", '%Y-%m-%d') => 17.7,
          Date.strptime("2011-06-08", '%Y-%m-%d') => 17.7,
          Date.strptime("2011-06-09", '%Y-%m-%d') => 17.8     
      }
                 
       tmd = TimeMachineData.new
       
       tmd.response = testresponse
       tmd.parse_sonar_response
       

              
  end
  

    
end