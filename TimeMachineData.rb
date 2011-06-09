class TimeMachineData

  attr_accessor :response, :data

  @response = Array.new
  
  def initialize
    @logger = Log.getLogger()
  end

  def parse_sonar_response

    @logger.debug("Parsing response: #{@response.inspect}")
    
    @data = Hash.new

    @response.delete_at(0)
    @response = @response.sort

    @response.each { |r| @data[Date.parse(r[0])] = r[1].to_f }

    @logger.debug("Parsed data     : [#{@data.to_a.join("; ")}]")
      
  end

end