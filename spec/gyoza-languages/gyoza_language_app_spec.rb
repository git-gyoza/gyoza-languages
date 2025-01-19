# frozen_string_literal: true

require 'gyoza-languages/gyoza_language_app'
require 'gyoza-languages/gyoza_error'

RSpec.describe GyozaLanguageApp do

  before(:each) do
    @app = GyozaLanguageApp.new '.'
  end

  it 'is initialized with an invalid repositories directory' do
    expect { GyozaLanguageApp.new 'invalid' }.to raise_error(GyozaError)
  end

  it 'should return 404 on not existing repository' do
    expect(@app.call(prep_env('invalid'))).to eq(@app.response(404, {
      'message' => 'Could not find repository: "invalid"',
    }))
  end

  it 'should return 404 on invalid repository' do
    expect(@app.call(prep_env('bin'))).to eq(@app.response(404, {
      'message' => 'Could not find repository: "bin"',
    }))
  end

  it 'should return 404 on invalid branch' do
    expect(@app.call(prep_env('', 'branch=invalid'))).to eq(@app.response(404, {
      'message' => 'Could not find branch: "invalid"',
    }))
  end

  ['', 'branch=main'].each do |query|
    it "should return 200 on query #{query}" do
      response = @app.call(prep_env('', query))
      expect(response[0]).to eq 200
      expect(response[2][0]).to include 'Ruby'
    end
  end

  def prep_env(path = '', query = '')
    return {
      'REQUEST_METHOD' => 'GET',
      'REQUEST_PATH' => path,
      'QUERY_STRING' => query
    }
  end

end
