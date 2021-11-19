class CoinWallet < ApplicationRecord
    belongs_to :coin
    belongs_to :wallet

    validates :quantity, presence: true

    def usd_value
        quantity * (coin.market_value_usd || 0)
    end

    def eur_value
        quantity * (coin.market_value_eur || 0)
    end

    def btc_value
        quantity * (coin.market_value_btc || 0)
    end
end