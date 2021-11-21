require 'api/coin_gecko/coin_value'

module Builders
  class SnapshotBuilder
    def intialize
      update_prices
    end

    def build
      snapshot = Snapshot.create!(
        total_usd_value: CoinWallet.total_usd_value,
        total_eur_value: CoinWallet.total_eur_value,
        total_btc_value: CoinWallet.total_btc_value,
        investment_eur: investment_eur,
        coin_snapshots_attributes: coin_snapshots_attributes
      )
    end

    def investment_eur
      @investment_eur ||= Config.fetch.investment_eur
    end

    def coin_snapshots_attributes
      owned_coins.map { |coin|  { coin_id: coin.id } }
    end

    def owned_coins
      Coin.all.select{|coin| coin.total_quantity > 0}
    end

    def update_prices
      api = Api::CoinGecko::CoinValue.new
      api.run
    end

  end
end