require 'net/http'
require_relative './base'

module Api 
  module CoinGecko
    class CoinList < Base

      def run
        response = self.class.get("/coins/list")
        all_coins = JSON.parse(response.body)
        create_or_update_coins(all_coins)
      end

      def create_or_update_coins(api_coins)
        api_coins.each do |api_coin|
          gecko_coin = GeckoCoin.find_or_create_by(api_id: api_coin['id'])
          gecko_coin.update(code: api_coin['symbol'], name: api_coin['name'])
        end
      end
    end
  end
end