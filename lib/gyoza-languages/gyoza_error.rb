# frozen_string_literal: true

# Represents a general error during the application execution
class GyozaError < StandardError
  private_class_method :new

  def self.invalidDirectory(directory)
    return GyozaError.new("\"#{directory}\" is not a valid directory.")
  end

end

