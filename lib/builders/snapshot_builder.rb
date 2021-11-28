# frozen_string_literal: true

require 'api/coin_gecko/coin_value'

module Builders
  class SnapshotBuilder
    def intialize(user)
      @user = user
      update_prices
    end

    def build
      Snapshot.create!(
        total_usd_value: @user.wealth.total_usd_value,
        total_eur_value: @user.wealth.total_eur_value,
        total_btc_value: @user.wealth.total_btc_value,
        investment: investment,
        coin_snapshots_attributes: coin_snapshots_attributes
      )
    end

    def investment
      @investment ||= @user.investment
    end

    def coin_snapshots_attributes
      owned_coins.map { |coin| { coin_id: coin.id } }
    end

    def owned_coins
      user.coins.select { |coin| coin.total_quantity.positive? }
    end

    def update_prices
      api = Api::CoinGecko::CoinValue.new
      api.run
    end
  end
end
