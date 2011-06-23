require 'app_log'

class TimeMachineData

  #attr_writer :response
  attr_reader :data
  def initialize(serverUrl=nil, project=nil, metric =nil)
    @logger = Log.getLogger()

    if !serverUrl.nil? then
      retrieve(serverUrl, project, metric)
      parse
    end

  end

  private
  @response = Array.new

  def retrieve(serverUrl, project, metric)

    @logger.info("Retrieving #{metric} metric on #{project}")
    httpresponse = Net::HTTP.post_form(URI.parse(serverUrl+'/api/timemachine'),
    {'resource' => "#{project}", 'metrics' => "#{metric}", 'format' => 'csv'});
    @logger.debug("Got HTTP response: #{httpresponse}")
    @response = CSV.parse(httpresponse.body)
    @logger.debug("Response body parsed: #{@response.inspect}")
    parse
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