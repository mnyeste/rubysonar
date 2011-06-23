require 'net/http'
require 'uri'
require 'csv'
require 'app_log'


class SonarConnector
  
  def initialize(serverUrl)
    
    @logger = Log.getLogger()
    
    @serverUrl=serverUrl

    @logger.info("Connecting to Sonar instance: #{serverUrl}")
  end



end