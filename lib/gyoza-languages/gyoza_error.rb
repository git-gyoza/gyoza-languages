# frozen_string_literal: true

# Represents a general error during the application execution
class GyozaError < StandardError
  private_class_method :new

  def self.invalidDirectory(directory)
    return GyozaError.new("\"#{directory}\" is not a valid directory.")
  end

  def self.serverAlreadyStarted(port)
    return GyozaError.new("Server is already listening on port #{port}.")
  end

  def self.serverNotStarted
    return GyozaError.new("Server has not been started yet.")
  end

end

