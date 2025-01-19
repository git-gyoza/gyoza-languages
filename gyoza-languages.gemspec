# frozen_string_literal: true

require 'rake'

require_relative 'lib/gyoza-languages/version'

Gem::Specification.new do |spec|
  spec.name = 'gyoza-languages'
  spec.version = GyozaLanguages::VERSION
  spec.authors = ['Fulminazzo']
  spec.email = ['gyoza@fulminazzo.it']

  spec.summary = 'A Ruby implementation of the Github linguist project with an integrated simple HTTP web server'
  spec.description = 'This Gem acts as a bridge between a simple Rest API and the Github linguist program, to allow for languages retrieval with easy and parameterized requests.'
  spec.homepage = 'https://git.fulminazzo.it'
  spec.required_ruby_version = '>= 3.1.0'

  spec.license = nil
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/git-gyoza/gyoza-languages'

  # Specify which files should be added to the gem when it is released.
  spec.files = FileList['lib/**/*.rb',
                        'bin/*',
                        '[A-Z]*'].to_a

  spec.bindir = 'bin'
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rake', '~> 13.0'
  spec.add_dependency 'erb', '~> 4.0.0'

  spec.add_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'github-linguist', '~> 9.0.0'

  spec.add_dependency 'puma', '~> 6.5.0'
  spec.add_dependency 'rack', '~> 3.1.8'
  spec.add_dependency 'rackup', '~> 2.2.1'
end
