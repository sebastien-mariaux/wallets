# frozen_string_literal: true

require 'api/coin_gecko/coin_value'

module Builders
  class SnapshotBuilder
    def initialize(user)
      @user = user
      update_prices
    end

    def build
      @user.snapshots.create!(create_data)
    end

    def create_data
      %i[currency_1 currency_2 currency_3 total_value_currency_1
         total_value_currency_2 total_value_currency_3 investment
         investment_currency coin_snapshots_attributes].each_with_object({}) do |key, data|
        data[key] = send(key)
      end
    end

    def currency_1
      @user.main_currency
    end

    def currency_2
      @user.secondary_currency
    end

    def currency_3
      @user.tertiary_currency
    end

    [1, 2, 3].each do |index|
      define_method "total_value_currency_#{index}" do
        @user.wealth.total_value(send("currency_#{index}"))
      end
    end

    def investment_currency
      @user.investment_currency
    end

    def investment
      @investment ||= @user.investment
    end

    def coin_snapshots_attributes
      owned_coins.map { |coin| { coin_id: coin.id } }
    end

    def owned_coins
      @user.coins.select { |coin| coin.total_quantity.positive? }
    end

    def update_prices
      api = Api::CoinGecko::CoinValue.new(@user)
      api.run
    end
  end
end
