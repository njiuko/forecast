$:.unshift File.expand_path('../lib', __FILE__)
require 'forecast/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'harvest-forecast'
  s.version     = '0.0.3'

  s.summary     = 'A Ruby wrapper for the Harvest Forecast API'
  s.description = s.summary

  s.authors     = ['Norman Timmler']
  s.email       = 'norman.timmler@njiuko.com'
  s.license     = 'MIT'

  s.required_ruby_version = ">= 2.2.2"

  s.files         = Dir["lib/**/*"]
  s.require_path  = "lib"

  s.add_dependency 'activesupport',      '~> 6.0'
  s.add_dependency 'addressable',        '~> 2.5'
  s.add_dependency 'faraday',            '~> 0.9'
  s.add_dependency 'faraday-cookie_jar', '~> 0.0.6'
  s.add_dependency 'faraday_middleware', '~> 0.10'
end

