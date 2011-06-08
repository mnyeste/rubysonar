require 'date'
require 'Log'
require 'SonarConnector'

logger = Log.getLogger()

start_date = Date.new(2011,5,1)
end_date = Date.new(2011,12,31)

logger.info("Starting...")
logger.info("Start date: #{start_date}")
logger.info("End date  : #{start_date}")

mondays = Array.new

start_date.upto(end_date) { |date| if date.cwday == 1 : mondays <<date end }
  
logger.info("Collected Mondays: [#{mondays.join(', ')}]")
  
     
SonarConnector.new.connect()




