# frozen_string_literal: true

module GyozaLanguages
  VERSION = '0.1.0'
  # The content sent as the HTTP Server header
  SERVER_NAME = "Gyoza-Languages/#{VERSION}"
  DEFAULT_PORT = 9172

  SPEC_NAME = $PROGRAM_NAME.split('/').last
  SPEC_DESCRIPTION = 'A Ruby implementation of the Github linguist project with an integrated simple HTTP web server'
  REPOSITORIES_DIRECTORY_ENV_NAME = 'REPOSITORIES_DIRECTORY'
end
