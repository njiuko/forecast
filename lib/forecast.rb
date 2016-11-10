require 'logger'
require 'optparse'

require 'rubygems'
require 'bundler/setup'
require 'active_support/all'
require 'faraday'
require 'faraday-cookie_jar'
require 'faraday_middleware'
require 'addressable/uri'
require 'dotenv'

Dotenv.load

require_relative 'forecast/faraday_middleware/forecast'
require_relative 'forecast/base'
require_relative 'forecast/person'
require_relative 'forecast/project'
require_relative 'forecast/assignment'

module Forecast
  extend self

  attr_accessor :account_id
  attr_accessor :email
  attr_accessor :password
  attr_writer   :logger

  def logger
    @logger ||= Logger.new(STDOUT).tap do |logger|
      logger.level = Logger::WARN
    end
  end

  def config
    yield self
  end

  def connection
    @connection ||= Faraday.new(url: 'https://api.forecastapp.com') do |faraday|
      faraday.request  :forecast, @account_id, @email, @password
      faraday.response :logger, logger
      faraday.response :json
      faraday.adapter  Faraday.default_adapter
    end
  end
end

Forecast.config do |f|
  f.account_id = ENV['FORECAST_ACCOUNT_ID']
  f.email      = ENV['FORECAST_EMAIL']
  f.password   = ENV['FORECAST_PASSWORD']
end

