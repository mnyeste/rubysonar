require 'date'
require 'Log'

class MetricTrend

  
  attr_reader :days
  
  WEEK = 1
  WORKDAY = 5
 
  def initialize(startdate, enddate, project, metric, frequency)

    @logger = Log.getLogger()
    
    @startdate = Date.strptime(startdate,'%Y-%m-%d')
    @enddate = Date.strptime(enddate, '%Y-%m-%d')
    @project = project
    @metric = metric
    @frequency = frequency

    @days = Hash.new

    @startdate.upto(@enddate) { |date| if date.cwday <= @frequency :  @days[date] = nil end }
     
    @logger.debug(inspect)

  end

  def merge(data) 
    
  end
  
  def inspect

    info = "\n\nMetric trend object\n"
    info<<Log::DELIMITER
    info<<"Start date: #{@startdate}\n"
    info<<"End date  : #{@enddate}\n"
    info<<"Project   : #{@project}\n"
    info<<"Metric    : #{@metric}\n"
    info<<"Frequency : #{@frequency}\n"
    info<<"Data begins...\n"
    @days.sort.each {|day| info<<"[#{day[0]};#{day[1]}]\n"}
    info<<"Data ends...\n"
    info<<Log::DELIMITER

  end

end