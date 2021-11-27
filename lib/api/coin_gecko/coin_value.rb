# frozen_string_literal: true

require 'net/http'
require_relative './base'

module Api
  module CoinGecko
    class CoinValue < Base
      PATH = '/simple/price'

      def run
        run_api_call(params) do
          update_coins(@response)
        end
      end

      def params
        { query: { ids: coins.pluck(:api_id).join(','),
                   vs_currencies: vs_currencies } }
      end

      def vs_currencies
        %w[eur usd btc].join(',')
      end

      def coins
        coins ||= Coin.joins(:gecko_coin)
                      .where.not(gecko_coin: { api_id: nil })
      end

      def update_coins(response)
        log("Response: #{response.code} (#{response.message})")
        @counter = 0
        response.each do |api_id, value_hash|
          update_coin api_id, value_hash
        end
        log "#{@counter} coins updated"
      end

      def update_coin(api_id, value_hash)
        coin = coins.find_by(gecko_coin: { api_id: api_id })
        @counter += 1 if coin.update(
          market_value_usd: value_hash['usd'],
          market_value_btc: value_hash['btc'],
          market_value_eur: value_hash['eur']
        )
      end

      def message
        'Mise à jour des prix terminée'
      end
    end
  end
end
