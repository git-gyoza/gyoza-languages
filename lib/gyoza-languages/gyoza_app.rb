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
    @repo_directory = repo_directory
  end

  # Starts a new server at the specified port (9172 by default).
  def start(port = 9172)
    @handler = Rackup::Handler.default
    @handler.run(self)
  end

  # Stops the server.
  def stop
    @handler.stop
  end

end
