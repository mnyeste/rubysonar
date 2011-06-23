require 'app_log'

require 'metric_trend'

logger = Log.getLogger()

logger.info("Starting...")


     
mt = MetricTrend.new('2011-05-01','2011-12-31','com.baxter.pe:price-engine','coverage',MetricTrend::WORKDAY)





