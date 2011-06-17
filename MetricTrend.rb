require 'date'
require 'Log'

class MetricTrend

  attr_reader :trend

  WEEK = 1
  WORKDAY = 5
  def initialize(startdate, enddate, project, metric, frequency)

    @logger = Log.getLogger()

    @startdate = Date.strptime(startdate,'%Y-%m-%d')
    @enddate = Date.strptime(enddate, '%Y-%m-%d')
    @project = project
    @metric = metric
    @frequency = frequency

    @trend = Hash.new

    @startdate.upto(@enddate) { |date| if date.cwday <= @frequency :  @trend[date] = nil end }

    @logger.debug("Object initialized...")
    @logger.debug(inspect)

  end

  def merge(data, end_date =  Date.today)
    @logger.debug("Merging data, end date is #{end_date}")

    trenddays = @trend.keys.delete_if {|d| d > end_date}.sort.reverse
    datadays = data.keys.delete_if {|d| d > end_date}.sort.reverse

    @logger.debug("Find data for days:     [#{trenddays.join(", ")}]")
    @logger.debug("Available data on days: [#{datadays.join(", ")}]")

    while !datadays.empty?&&!trenddays.empty?

      td = trenddays.shift

      @logger.debug("Processing day  : #{td}")
      @logger.debug("Current data day: #{datadays.first}")

      while !datadays.empty?&&datadays.first>td
        @logger.debug("Dropping data on day #{datadays.first}")
        datadays.shift
        @logger.debug("Datadays length: #{datadays.length}")
      end

      @trend[td] = data[datadays.first]

    end

    @logger.debug("Object merged...")
    @logger.debug(inspect)

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
    @trend.sort.each {|day| info<<"[#{day[0]};#{day[1].inspect}]\n"}
    info<<"Data ends...\n"
    info<<Log::DELIMITER

  end

end