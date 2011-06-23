require 'net/http'
require 'uri'
require 'csv'
require 'Log'


class SonarConnector
  
  def initialize(serverUrl)
    
    @logger = Log.getLogger()
    
    @serverUrl=serverUrl

    @logger.debug("Connecting to Sonar instance: #{serverUrl}")
  end

  def retrieve_time_machine_data(project, metric)
                           
    CSV.parse(Net::HTTP.post_form(URI.parse(@serverUrl+'/api/timemachine'),
    {'resource' => "#{project}", 'metrics' => "#{metric}", 'format' => 'csv'}).body)
                               
  end

end