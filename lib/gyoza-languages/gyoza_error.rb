# frozen_string_literal: true

# Represents a general RuntimeError during the application execution
class GyozaError < RuntimeError

  def self.invalidDirectory(directory)
    return GyozaError.new("\"#{directory}\" is not a valid directory.")
  end

  def self.serverAlreadyStarted(port)
    return GyozaError.new("Server is already listening on port #{port}.")
  end

  def self.serverNotStarted
    return GyozaError.new("Server has not been started yet.")
  end

  def self.invalidStatusCode(code)
    return GyozaError.new("Invalid status code #{code}. Expecting value between 100 and 599.")
  end

end

