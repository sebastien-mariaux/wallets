# frozen_string_literal: true

module Api
  module CoinGecko
    class Base
      include HTTParty

      attr_accessor :message

      base_uri 'https://api.coingecko.com/api/v3'

      def run_api_call(params)
        log("GET #{self.class::PATH}")
        begin
          @response = self.class.get(self.class::PATH, params)
          yield
        rescue Exception => e
          log(e)
        end
        log('Completed')
        log('---------')
      end

      def log(text)
        File.open('log/api.log', 'a') do |f|
          f.puts formatted(text)
        end
      end

      def formatted(text)
        "#{DateTime.current} - [GECKO] - #{text}"
      end
    end
  end
end
