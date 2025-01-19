# frozen_string_literal: true

require 'gyoza-languages/gyoza_language_app'
require 'gyoza-languages/gyoza_error'

RSpec.describe GyozaLanguageApp do

  before(:each) do
    @app = GyozaLanguageApp.new "."
  end

  it "is initialized with an invalid repositories directory" do
    expect { GyozaLanguageApp.new "invalid" }.to raise_error(GyozaError)
  end

  it "should return 404 on invalid repository" do
    expect(@app.call(prep_env('invalid'))).to eq(@app.response(404, {
      "message" => "Could not find repository: \"invalid\"",
    }))
  end

  def prep_env(path = "", query = "")
    return {
      "REQUEST_METHOD" => "GET",
      "REQUEST_PATH" => path,
      "QUERY_STRING" => query
    }
  end

end
