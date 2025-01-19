# frozen_string_literal: true

require 'rackup'
require 'rugged'
require 'linguist'

# The basic gyoza-languages app entry point.
# Works with rackup to start a new HTTP server.
class GyozaApp

  # Initializes the GyozaApp,
  # Arguments:
  #   repo_directory: the location where all the repositories are stored
  def initialize(repo_directory)
    if File.directory?(repo_directory)
      @repo_directory = repo_directory
    else
      raise GyozaError.invalidDirectory(repo_directory)
    end
  end

  # Starts a new server at the specified port (9172 by default).
  def start(port = 9172)
    if @handler == nil
      @handler = Rackup::Handler.default
      @port = port
      @handler.run(self, :Port => port)
    else
      raise GyozaError.serverAlreadyStarted(port)
    end
  end

  # Stops the server.
  def stop
    if @handler == nil
      raise GyozaError.serverNotStarted()
    else
      @handler.stop
      @handler = nil
      @port = nil
    end
  end

end
