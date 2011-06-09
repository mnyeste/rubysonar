class TimeMachineData

  attr_accessor :response, :data
  
  @response = Array.new
  
  def parse_sonar_response

    @data = Hash.new
    
    @response.delete_at(0)
    
    @response.each do |r|
     
      puts r.inspect

    end

  end

end