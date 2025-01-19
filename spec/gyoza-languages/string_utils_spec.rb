# frozen_string_literal: true

require 'gyoza-languages/string_utils'

RSpec.describe StringUtils do

  it "should return the correct hash" do
    expected = {
      "version" => "1.0",
      "name" => "Fulminazzo",
      "message" => "Hello World!",
    }
    query = "version=1.0&name=Fulminazzo&message=Hello+World!"
    expect(StringUtils.query_string_to_hash(query)).to eq(expected)
  end

end