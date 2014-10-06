# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'push_bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'push_bot'
  spec.version       = PushBot::VERSION
  spec.authors       = ['Brian Norton']
  spec.email         = ['brian.nort@gmail.com']
  spec.summary       = 'A Ruby interface to the PushBots API'
  spec.description   = 'Register, Push to and get information about devices on your account.'
  spec.homepage      = 'https://github.com/push_bot'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_runtime_dependency 'typhoeus', '~> 0.6'
end
