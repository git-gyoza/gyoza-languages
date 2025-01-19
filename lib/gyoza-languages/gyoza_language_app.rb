# frozen_string_literal: true

require_relative 'gyoza_app'

# An implementation of GyozaApp that works with GitHub linguist.
class GyozaLanguageApp < GyozaApp

  # Checks in the repositories directory for the given repository
  # in the path. If found, uses GitHub linguist to compute the
  # used languages and returns them in a JSON format.
  # Otherwise, 404 'Not Found' is returned.
  #
  # Arguments:
  #   path: the path of the repository
  #   query: a hash of arguments. If the "branch" argument is specified, then
  #          the languages will be looked for that particular branch. However,
  #          if not found a 404 'Not Found' error is returned
  #   env: the environment variables at the time of receiving the request
  def get(path, query, env)
    #TODO:
  end

end
