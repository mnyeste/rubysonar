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

  def retrieve_time_machine_data(project, metric)
    
    @logger.info("Retrieving #{metric} metric on #{project}")
    response = Net::HTTP.post_form(URI.parse(@serverUrl+'/api/timemachine'),
    {'resource' => "#{project}", 'metrics' => "#{metric}", 'format' => 'csv'});
    @logger.debug("Got response: #{response}")
                           
    body = CSV.parse(response.body)
    
    @logger.debug("Response body: #{body.inspect}")                           
    
    return body
  end

end