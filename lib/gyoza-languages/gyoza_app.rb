# frozen_string_literal: true

require 'rackup'
require 'rugged'
require 'linguist'

require_relative './string_utils'

# A wrapper for a web server.
# Works with rackup to start a new HTTP server.
class GyozaApp
  attr_accessor :handler, :port

  # Starts a new server at the specified port
  # using a Rackup handler which is stored in the 'handler' attribute.
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

  # The method invoked by Puma when receiving
  # an HTTP request.
  #
  # Uses get, post, put, patch and delete methods to
  # separate requests.
  # If the REQUEST_METHOD does not match any
  # of the previously mentioned methods,
  # returns the 405 HTTP status code.
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
    when "PATCH"
      patch(path, query, env)
    when "DELETE"
      delete(path, query, env)
    else
      status_code 405
    end
  end

  # The response to a GET request.
  # By default, returns the 405 HTTP status code.
  #
  # Arguments:
  #   path: the path of the repository
  #   query: a hash containing all the query parameters
  #   env: the environment variables at the time of receiving the request
  def get(path, query, env)
    status_code 405
  end

  # The response to a POST request.
  # By default, returns the 405 HTTP status code.
  #
  # Arguments:
  #   path: the path of the repository
  #   query: a hash containing all the query parameters
  #   env: the environment variables at the time of receiving the request
  def post(path, query, env)
    status_code 405
  end

  # The response to a PUT request.
  # By default, returns the 405 HTTP status code.
  #
  # Arguments:
  #   path: the path of the repository
  #   query: a hash containing all the query parameters
  #   env: the environment variables at the time of receiving the request
  def put(path, query, env)
    status_code 405
  end

  # The response to a PATCH request.
  # By default, returns the 405 HTTP status code.
  #
  # Arguments:
  #   path: the path of the repository
  #   query: a hash containing all the query parameters
  #   env: the environment variables at the time of receiving the request
  def patch(path, query, env)
    status_code 405
  end

  # The response to a DELETE request.
  # By default, returns the 405 HTTP status code.
  #
  # Arguments:
  #   path: the path of the repository
  #   query: a hash containing all the query parameters
  #   env: the environment variables at the time of receiving the request
  def delete(path, query, env)
    status_code 405
  end

  # Returns the given status code with a message
  # in the Rackup expected format.
  #
  # Arguments:
  #   code: the status code
  #   message: an optional message
  def status_code(code, message = "")
    [code, {}, message.empty? ? [] : [message]]
  end

end
