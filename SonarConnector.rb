require 'net/http'
require 'uri'
require 'csv'


class SonarConnector
  
  def initialize(server)
    @server=server
  end

  def get_time_machine_data(project, metric)

    res = Net::HTTP.post_form(URI.parse(@server+'/api/timemachine'),
                           {'resource' => "#{project}", 'metrics' => "#{coverage}", 'format' => 'csv'})
                            
    a = CSV.parse(res.body)
    puts a.inspect
                                
  end

end