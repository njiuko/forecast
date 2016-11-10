module Forecast
  module FaradayMiddleware
    class Forecast < Faraday::Middleware
      def initialize(app, account_id, email, password)
        super(app)
        @account_id = account_id
        @email = email
        @password = password
      end

      def call(env)
        env[:request_headers]['Authorization'] ||= "Bearer #{token}"
        env[:request_headers]['Forecast-Account-ID'] ||= @account_id.to_s
        @app.call(env)
      end

      private

      def token
        @token ||= begin
                     create_session(authenticity_token)
                     authorization_token
                   end
      end

      def authenticity_token
        response = harvest.get '/sessions/new'
        response.body.match(/authenticity_token\" value=\"(.+?)\"/) && $1
      end

      def create_session(authenticity_token)
        harvest.post '/sessions',
          email: @email, password: @password, authenticity_token: authenticity_token
        # The cookie is saved in the jar.
      end

      def authorization_token
        response = harvest.get "/accounts/#{@account_id}"
        response.headers['location'].match(/access_token\/(.+)\?/) && $1
      end

      def harvest
        @conn ||= Faraday.new(url: 'https://id.getharvest.com') do |faraday|
          faraday.use      :cookie_jar
          faraday.request  :url_encoded
          faraday.response :logger, Logger.new(STDOUT).tap {|logger| logger.level = Logger::WARN }
          faraday.adapter Faraday.default_adapter
        end
      end
    end
  end
end

Faraday::Request.register_middleware forecast: -> { Forecast::FaradayMiddleware::Forecast }

