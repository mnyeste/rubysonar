require 'date'
require 'Log'

class MetricTrend

  
  attr_accessor :days
  
  WEEK = 1
  WORKDAY = 5
 
  def initialize(startdate, enddate, project, metric, frequency)

    @startdate = Date.strptime(startdate,'%Y-%m-%d')
    @enddate = Date.strptime(enddate, '%Y-%m-%d')
    @project = project
    @metric = metric
    @frequency = frequency

    @days = Array.new

    @startdate.upto(@enddate) { |date| if date.cwday <= @frequency :  @days<<date end }

    @logger = Log.getLogger()

    @logger.debug(inspect)

  end

  def inspect

    info = "\n\nMetric trend object\n"
    info<<"-"*60+"\n"
    info<<"Start date: #{@startdate}\n"
    info<<"End date  : #{@enddate}\n"
    info<<"Project   : #{@project}\n"
    info<<"Metric    : #{@metric}\n"
    info<<"Frequency : #{@frequency}\n"
    info<<"Days      : [#{@days.join('; ')}]\n"
    info<<"-"*60+"\n"

  end

end