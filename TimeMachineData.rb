class TimeMachineData

  attr_writer :response
  attr_reader :data

  @response = Array.new
  
  def initialize(response)
    @logger = Log.getLogger()
    @response = response
    parse_sonar_response()
  end

  private
  def parse_sonar_response

    @logger.debug("Parsing response: #{@response.inspect}")
    
    @data = Hash.new

    @response.delete_at(0)
    @response = @response.sort

    @response.each { |r| @data[Date.parse(r[0])] = r[1].to_f }

    @logger.debug("Parsed data     : [#{@data.sort.join("; ")}]")
      
  end

end