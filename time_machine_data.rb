require 'app_log'

class TimeMachineData

  attr_reader :data
  def initialize(serverUrl, project, metric)
    @logger = Log.getLogger()
    retrieve(serverUrl, project, metric)
    parse
  end

  private
  @response = Array.new

  def retrieve(serverUrl, project, metric)

    @logger.info("Retrieving #{metric} metric on #{project}")
    httpresponse = Net::HTTP.post_form(URI.parse(serverUrl+'/api/timemachine'),
                    {'resource' => "#{project}", 'metrics' => "#{metric}", 'format' => 'csv'});
    @logger.debug("Got HTTP response: #{httpresponse}")
    @response = CSV.parse(httpresponse.body)
  end

  def parse

    @logger.debug("Parsing response: #{@response.inspect}")

    @data = Hash.new

    @response.delete_at(0)
    @response.sort!

    @response.each { |r| @data[Date.parse(r[0])] = r[1].to_f }

    @logger.debug("Parsed data     : [#{@data.sort.join("; ")}]")

  end

end