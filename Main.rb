require 'date'
require 'Log'
require 'SonarConnector'
require 'MetricTrend'

logger = Log.getLogger()

logger.info("Starting...")

sonar = SonarConnector.new("http://sourcecontrol:8001")
     
MetricTrend.new('2011-05-01','2011-12-31','com.baxter.pe:price-engine','coverage',MetricTrend::WORKDAY)



