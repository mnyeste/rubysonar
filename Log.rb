require 'logger'

class Log

  @@log = nil
   
  def self.getLogger()

    if @@log.nil?
      @@log = Logger.new(STDOUT)
      @@log.formatter = proc { |severity, datetime, progname, msg| "#{severity} - #{datetime}: #{msg}\n" }
      @@log.level = Logger::DEBUG
      
    end

    return @@log
  end

end