# frozen_string_literal: true

# A collection of utilities for strings.
module StringUtils

  # Converts the given query String to a Hash object.
  # A query string is identified by a set of
  # key-value pairs in the format "{key}={value}"
  # separated by the '&' character.
  #
  # Arguments:
  #   string: the string to convert
  def self.query_string_to_hash(string)
    dict = {}
    string.split("&").map do |pair|
      key, value = pair.split("=")
      dict[key] = value.sub("+", " ")
    end
    dict
  end

end