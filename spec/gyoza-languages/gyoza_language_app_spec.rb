# frozen_string_literal: true

require 'gyoza-languages/gyoza_language_app'
require 'gyoza-languages/gyoza_error'

RSpec.describe GyozaLanguageApp do

  it "is initialized with an invalid repositories directory" do
    expect { GyozaLanguageApp.new 'invalid' }.to raise_error(GyozaError)
  end

end
