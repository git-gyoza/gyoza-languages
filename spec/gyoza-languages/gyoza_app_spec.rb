# frozen_string_literal: true

require 'gyoza-languages/gyoza_app'
require 'gyoza-languages/gyoza_error'

RSpec.describe GyozaApp do

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
