# frozen_string_literal: true

# A collection of utilities for the tests in this directory.
module GyozaHelper

  # Represents a mock class for a Rackup Handler.
  # Provides default run and stop methods.
  class MockHandler
    attr_accessor :started, :caller, :port

    def initialize
      stop
    end

    def run(caller, options = {})
      if options.include? :Port
        @port = options[:Port]
      end
      @started = true
      @caller = caller
    end

    def stop
      @port = nil
      @started = false
      @caller = nil
    end

  end

end

# Overrides the default Rackup Handler.
# For testing purposes only.
module Rackup
  module Handler
    def self.default(options = {})
      return GyozaHelper::MockHandler.new
    end
  end
end
