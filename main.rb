require 'date'
require 'app_log'
require 'sonar_connector'
require 'metric_trend'

logger = Log.getLogger()

logger.info("Starting...")

sonar = SonarConnector.new("http://sourcecontrol:8001")
     
mt = MetricTrend.new('2011-05-01','2011-12-31','com.baxter.pe:price-engine','coverage',MetricTrend::WORKDAY)





