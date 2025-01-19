# frozen_string_literal: true

require 'gyoza-languages/gyoza_app'
require 'gyoza-languages/gyoza_error'

RSpec.describe GyozaApp do

  ["GET", "POST", "PUT", "PATCH", "DELETE"].each do |method|
    it "should return 405 by default when requesting #{method}" do
      expect(GyozaApp.new('.')
                     .call({
                             "REQUEST_METHOD" => method,
                             "REQUEST_PATH" => "",
                             "QUERY_STRING" => "" })
      ).to eq([405, {}, []])
    end
  end

  it "is initialized with an invalid repositories directory" do
    expect { GyozaApp.new 'invalid' }.to raise_error(GyozaError)
  end

  it "is started after being started" do
    app = GyozaApp.new '.'
    app.handler = 'Mock value'
    app.port = 8080
    expect { app.start }.to raise_error(GyozaError)
  end

  it "is stopped without the server actually running" do
    expect { GyozaApp.new('.').stop }.to raise_error(GyozaError)
  end

end
