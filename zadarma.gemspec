# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'zadarma'
  s.version       = '2.0.0'
  s.summary       = 'A modern, robust, and tested Ruby client for the Zadarma API'
  s.description   = 'A modern, robust, and fully-featured Ruby client for the Zadarma API.'
  s.authors       = ['Damir Mukimov']
  s.email         = 'info@glpx.pro'
  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']
  s.homepage      = 'https://github.com/SamyRai/zadarma-ruby'
  s.license       = 'MIT'
  s.metadata['rubygems_mfa_required'] = 'true'

  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'faraday', '~> 2.7'
  s.add_dependency 'json'

  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rubocop', '~> 1.0'
  s.add_development_dependency 'rubocop-rspec', '~> 2.0'
  s.add_development_dependency 'webmock', '~> 3.0'
end
