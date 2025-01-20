# frozen_string_literal: true

require 'gyoza-languages/gyoza_app'
require 'gyoza-languages/gyoza_error'
require_relative './gyoza_helper'

RSpec.describe GyozaApp do

  ['nil', 1234].each do |port|
    it "should start with mock handler and port #{port}" do
      app = GyozaApp.new
      if port == 'nil'
        app.start
        port = GyozaLanguages::DEFAULT_PORT
      else
        app.start port
      end

      handler = app.handler
      expect(handler).to_not be_nil
      expect(handler.started).to eq(true)
      expect(handler.caller).to eq(app)
      expect(handler.port).to eq(port)
    end
  end

  it 'should raise error when is started after being started' do
    app = GyozaApp.new
    app.start
    expect { app.start }.to raise_error(GyozaError)
  end

  it 'should stop handler' do
    app = GyozaApp.new
    app.start
    handler = app.handler
    app.stop

    expect(app.handler).to be_nil
    expect(handler.started).to eq(false)
    expect(handler.caller).to be_nil
    expect(handler.port).to be_nil
  end

  it 'should raise error when is stopped without the server actually running' do
    expect { GyozaApp.new.stop }.to raise_error(GyozaError)
  end

  ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD', 'SOMETHING_ELSE'].each do |method|
    it "should return 405 by default when requesting #{method}" do
      expect(GyozaApp.new.call({
                                 'REQUEST_METHOD' => method,
                                 'REQUEST_PATH' => '',
                                 'QUERY_STRING' => '' })[0]
      ).to eq(405)
    end
  end

  [0, 99, 600, 1000].each do |code|
    it "should raise error when using #{code} as status code in response method" do
      expect { GyozaApp.new.response(code) }.to raise_error(GyozaError)
    end
  end

  it 'should properly capitalize all headers in response method' do
    expected = {
      'Good' => 'Luck',
      'Hello' => 'World',
      'Remember-To' => 'Enjoy Yourselves',
      'Server' => GyozaLanguages::SERVER_NAME,
      'This-Is' => 'a test',
    }
    headers = {
      'hello' => 'World',
      'THIS-is' => 'a test',
      'remember-TO' => 'Enjoy Yourselves',
      'GOOD' => 'Luck',
    }
    actual = GyozaApp.new.response(100, nil, headers)[1]
    actual.delete('Date')
    expect(actual).to eq(expected)
  end

  it 'should provide the correct date with timezone in response method' do
    headers = GyozaApp.new.response(100, nil, {})[1]
    date = headers['Date']
    expected = Time.now.utc.strftime('%a, %d %b %Y %H:%M:%S GMT')
    expect(date).to eq(expected)
  end

  {
    'nil' => 'nil',
    'Hello, World!' => 'text/plain',
    {1 => 2} => 'application/json'
  }.each do |body, expected|
    it "should provide #{expected} content-type header based on #{body} body in response method" do
      headers = GyozaApp.new.response(200, body == 'nil' ? nil : body)[1]
      actual = headers['Content-Type']
      expect(actual).to eq expected == 'nil' ? nil : expected
    end
  end

end
