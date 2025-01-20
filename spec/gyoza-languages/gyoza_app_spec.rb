# frozen_string_literal: true

require 'gyoza-languages/gyoza_app'
require 'gyoza-languages/gyoza_error'

RSpec.describe GyozaApp do

  it 'should raise error when is started after being started' do
    app = GyozaApp.new
    app.handler = 'Mock value'
    app.port = 8080
    expect { app.start }.to raise_error(GyozaError)
  end

  it 'should raise error when is stopped without the server actually running' do
    expect { GyozaApp.new.stop }.to raise_error(GyozaError)
  end

  ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'SOMETHING_ELSE'].each do |method|
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
