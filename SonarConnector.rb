require 'net/http'
require 'uri'
require 'csv'


class SonarConnector
  def connect()

    res = Net::HTTP.post_form(URI.parse('http://sourcecontrol:8001/api/timemachine'),
                           {'resource' => 'com.baxter.pe:price-engine', 'metrics' => 'coverage', 'format' => 'csv'})
       
                             
    a = CSV.parse(res.body)
    
    puts a.inspect

    
                             
                                 
  end

end