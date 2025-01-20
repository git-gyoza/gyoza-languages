# frozen_string_literal: true

require 'rackup'
require 'rugged'
require 'linguist'
require 'json'

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
  #   port: the port to start the server at
  def start(port = GyozaLanguages::DEFAULT_PORT)
    if @handler.nil?
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
    if @handler.nil?
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
    method = env['REQUEST_METHOD']
    path = env['REQUEST_PATH']
    query = StringUtils.query_string_to_hash(env['QUERY_STRING'])
    case method
    when 'GET'
      get(path, query, env)
    when 'POST'
      post(path, query, env)
    when 'PUT'
      put(path, query, env)
    when 'PATCH'
      patch(path, query, env)
    when 'DELETE'
      delete(path, query, env)
    else
      response 405
    end
  end

  # The response to a GET request.
  # By default, returns the 405 HTTP status code.
  #
  # Arguments:
  #   path: the path of the repository
  #   query: a hash containing all the query parameters
  #   env: the environment variables at the time of receiving the request
  protected def get(path, query, env)
    response 405
  end

  # The response to a POST request.
  # By default, returns the 405 HTTP status code.
  #
  # Arguments:
  #   path: the path of the repository
  #   query: a hash containing all the query parameters
  #   env: the environment variables at the time of receiving the request
  protected def post(path, query, env)
    response 405
  end

  # The response to a PUT request.
  # By default, returns the 405 HTTP status code.
  #
  # Arguments:
  #   path: the path of the repository
  #   query: a hash containing all the query parameters
  #   env: the environment variables at the time of receiving the request
  protected def put(path, query, env)
    response 405
  end

  # The response to a PATCH request.
  # By default, returns the 405 HTTP status code.
  #
  # Arguments:
  #   path: the path of the repository
  #   query: a hash containing all the query parameters
  #   env: the environment variables at the time of receiving the request
  protected def patch(path, query, env)
    response 405
  end

  # The response to a DELETE request.
  # By default, returns the 405 HTTP status code.
  #
  # Arguments:
  #   path: the path of the repository
  #   query: a hash containing all the query parameters
  #   env: the environment variables at the time of receiving the request
  protected def delete(path, query, env)
    response 405
  end

  # Formats a new HTTP response from the given HTTP status code.
  #
  # Arguments:
  #   code: the status code
  #   body: the data sent to the client. The method will first try to
  #         convert the data in Json (unless it is String). If it fails,
  #         it will return the data accordingly
  #   headers: the headers to pass to the response.
  #            By default, this value is empty, and will be populated
  #            with the server name and current date
  def response(code, body = nil, headers = {})
    if code < 100 || code > 599
      raise GyozaError.invalidStatusCode(code)
    end

    actual_headers = {}
    headers.each do |key, value|
      actual_headers[key.to_s.titleize] = value
    end
    headers = actual_headers

    headers['Server'] = GyozaLanguages::SERVER_NAME
    headers['Date'] = Time.now.utc.strftime('%a, %d %b %Y %H:%M:%S GMT')

    unless body.nil?
      if body.is_a?(String)
        headers['Content-Type'] = 'text/plain'
      else
        body = JSON.dump(body)
        headers['Content-Type'] = 'application/json'
      end
    end

    [code, headers, body.nil? ? [] : [body]]
  end

end
