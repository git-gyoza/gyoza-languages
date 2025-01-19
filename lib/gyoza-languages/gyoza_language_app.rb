# frozen_string_literal: true

require 'rugged'
require 'linguist'

require_relative 'gyoza_app'

# An implementation of GyozaApp that works with GitHub linguist.
class GyozaLanguageApp < GyozaApp
  attr_accessor :repo_directory

  # Initializes the Gyoza Language App.
  #
  # Arguments:
  #   repo_directory: the location where all the repositories are stored
  def initialize(repo_directory)
    if File.directory?(repo_directory)
      @repo_directory = repo_directory
    else
      raise GyozaError.invalidDirectory(repo_directory)
    end
  end

  # Checks in the repositories directory for the given repository
  # in the path. If found, uses GitHub linguist to compute the
  # used languages and returns them in a Json format.
  # Otherwise, 404 'Not Found' is returned.
  #
  # Arguments:
  #   path: the path of the repository
  #   query: a hash of arguments. If the "branch" argument is specified, then
  #          the languages will be looked for that particular branch. However,
  #          if not found a 404 'Not Found' error is returned
  #   env: the environment variables at the time of receiving the request
  protected def get(path, query, env)
    repository = "#{@repo_directory}/#{path}"
    unless File.directory?(repository)
      #TODO: 404
    end

    repo = Rugged::Repository.new(repository)
    if query.include? "branch"
      #TODO: change branch and handle error
    end

    project = Linguist::Repository.new(repo, repo.head.target_id)
    languages = project.languages
    #TODO: return languages
  end

end
