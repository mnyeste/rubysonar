require 'app_log'
require 'net/http'
require 'csv'

class TimeMachineData

  attr_reader :data
  def initialize(serverUrl, project, metric)
    @logger = Log.getLogger()
    retrieve(serverUrl, project, metric)
    if !@response.nil? : parse end

  end

  private
  @response = Array.new

  def retrieve(serverUrl, project, metric)

    @logger.info("Retrieving #{metric} metric on #{project} from #{serverUrl}")

    begin

      httpresponse = Net::HTTP.post_form(URI.parse(serverUrl+'/api/timemachine'),
      {'resource' => "#{project}", 'metrics' => "#{metric}", 'format' => 'csv'});

      @logger.debug("Got HTTP response: #{httpresponse.inspect}")

      if httpresponse.class == Net::HTTPOK then
        @response = CSV.parse(httpresponse.body)
      else
        @logger.info("Response is not HTTP 200: #{httpresponse.inspect}")
        @response = nil
      end

    rescue Exception => e
      @logger.fatal("Failed to connect server: #{serverUrl}")
      @logger.fatal(e.message)  
      @logger.fatal(e.backtrace.join("\n"))  
      @response = nil
    end

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