require 'date'
require 'Log'
require 'SonarConnector'
require 'MetricTrend'

logger = Log.getLogger()

start_date = Date.new(2011,5,1)
end_date = Date.new(2011,12,31)


logger.info("Starting...")

MetricTrend.new('2011-05-01','2011-12-31','com.baxter.pe:price-engine','coverage',MetricTrend::WORKDAY)

     
#SonarConnector.new.connect()




