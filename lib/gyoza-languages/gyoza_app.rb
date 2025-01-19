# frozen_string_literal: true

require 'rackup'
require 'rugged'
require 'linguist'

require_relative './string_utils'

# The basic gyoza-languages app entry point.
# Works with rackup to start a new HTTP server.
class GyozaApp
  attr_accessor :repo_directory, :handler, :port

  # Initializes the GyozaApp.
  #
  # Arguments:
  #   repo_directory: the location where all the repositories are stored
  def initialize(repo_directory)
    if File.directory?(repo_directory)
      @repo_directory = repo_directory
    else
      raise GyozaError.invalidDirectory(repo_directory)
    end
  end

  # Starts a new server at the specified port
  # using a Rackup Handler which is stored in the 'handler' attribute.
  #
  # If the server is already running (A.K.A. the handler attribute is set),
  # a GyozaError is raised.
  #
  # Arguments:
  #   port: the port to start the server at (9172 by default)
  def start(port = 9172)
    if @handler == nil
      @handler = Rackup::Handler.default
      @port = port
      @handler.run(self, :Port => port)
    else
      raise GyozaError.serverAlreadyStarted(port)
    end
  end

  # The method invoked by Puma when receiving
  # an HTTP request.
  #
  # Uses get, post, put and delete methods to
  # separate requests.
  # If the REQUEST_METHOD does not match any
  # of the previously mentioned methods,
  # returns 405 Method not allowed.
  #
  # Arguments:
  #   env: the environment variables at the time of receiving the request
  def call(env)
    method = env["REQUEST_METHOD"]
    path = env["REQUEST_PATH"]
    query = StringUtils.query_string_to_hash(env["QUERY_STRING"])
    case method
    when "GET"
      get(path, query, env)
    when "POST"
      post(path, query, env)
    when "PUT"
      put(path, query, env)
    when "DELETE"
      delete(path, query, env)
    else
      [405, {}, []]
    end
  end

  # Computes a get request
  #
  # Arguments:
  #   env: the environment variables at the time of receiving the request
  #def get(env)

  # Stops the server.
  #
  # If the server is not running (A.K.A. the handler attribute is not set),
  # a GyozaError is raised.
  def stop
    if @handler == nil
      raise GyozaError.serverNotStarted
    else
      @handler.stop
      @handler = nil
      @port = nil
    end
  end

end

GyozaApp.new('.').start 10000
