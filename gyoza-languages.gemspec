# frozen_string_literal: true

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

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/git-gyoza/gyoza-languages'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines('\x0', chomp: true).reject do |f|
      (f == gemspec) || f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end

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
