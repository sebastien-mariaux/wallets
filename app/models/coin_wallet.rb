class CoinWallet < ApplicationRecord
    belongs_to :coin
    belongs_to :wallet

    validates :quantity, presence: true

    def self.total_usd_value
        CoinWallet.all.inject(0) do |sum, wallet|
            sum += wallet.usd_value
        end
    end

    def self.total_eur_value
        CoinWallet.all.inject(0) do |sum, wallet|
            sum += wallet.eur_value
        end
    end

    def self.total_btc_value
        CoinWallet.all.inject(0) do |sum, wallet|
            sum += wallet.btc_value
        end
    end

    def usd_value
        (quantity * (coin.market_value_usd || 0)).to_f
    end

    def eur_value
        (quantity * (coin.market_value_eur || 0)).to_f
    end

    def btc_value
        (quantity * (coin.market_value_btc || 0)).to_f
    end
end