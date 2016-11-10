module Forecast
  class Base
    attr_reader :attributes

    def self.connection
      Forecast.connection
    end

    def self.url_name
      self.name.demodulize.underscore.pluralize
    end

    def self.all(query = {})
      uri = Addressable::URI.new
      uri.query_values = query

      url = "/#{url_name}"
      url << "?#{uri.query}" if query.any?

      @all ||= connection.get(url).body[url_name].map do |attributes|
        new(attributes)
      end
    end

    def initialize(attributes = {})
      @attributes = attributes
    end

    private

    def method_missing(name)
      key = name.to_s
      if @attributes.key?(key.to_s)
        @attributes[key]
      else
        super
      end
    end
  end
end
