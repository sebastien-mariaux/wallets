# frozen_string_literal: true

require 'net/http'
require_relative './base'

module Api
  module CoinGecko
    class CoinValue < Base
      PATH = '/simple/price'

      def initialize(user)
        @user = user
      end

      def run
        run_api_call(params) do
          update_coins(@response)
        end
      end

      def params
        { query: { ids: coins.pluck(:api_id).join(','),
                   vs_currencies: vs_currency_param } }
      end

      def vs_currencies
        return @vs_currencies if @vs_currencies

         @vs_currencies = [@user.main_currency]
         @vs_currencies << 'usd' if @user.display_usd
         @vs_currencies << 'btc' if @user.display_btc
         @vs_currencies
      end

      def vs_currency_param
        vs_currencies.uniq.join(',')
      end

      def coins
        coins ||= GeckoCoin.applied
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
        coin = coins.find_by(api_id: api_id)
        @counter += 1 if coin.update(update_params(value_hash))
      end

      def update_params(value_hash)
        vs_currencies.inject({}) do |hash, curr|
          hash["market_value_#{curr}"] = value_hash[curr]
          hash
        end
      end

      def message
        'Mise à jour des prix terminée'
      end
    end
  end
end
