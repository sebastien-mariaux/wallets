require 'net/http'
require_relative './base'

module Api 
  module CoinGecko
    class CoinValue < Base
      def run
        response = self.class.get("/simple/price", params)
        update_coins(response)
      end

      def params
        { query: {ids: coins.pluck(:api_id).join(','), 
                  vs_currencies: vs_currencies }}
      end

      def vs_currencies
        ['eur', 'usd', 'btc'].join(',')
      end

      def coins
        coins ||= Coin.joins(:gecko_coin)
                      .where.not(gecko_coin: {api_id: nil})
      end

      def update_coins(response)
        response.each do |api_id, value_hash|
          coin = coins.find_by(gecko_coin: {api_id: api_id})
          coin.update(
            market_value_usd: value_hash['usd'],
            market_value_btc: value_hash['btc'],
            market_value_eur: value_hash['eur']
          )
        end
      end
    end
  end
end


# {"hedera-hashgraph"=>{"usd"=>0.388959}, "ethereum"=>{"usd"=>4392.35}, "cardano"=>{"usd"=>1.92}, "basic-attention-token"=>{"usd"=>1.09}, "bitcoin"=>{"usd"=>59723}, "cu