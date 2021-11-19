class CoinWallet < ApplicationRecord
    belongs_to :coin
    belongs_to :wallet

    validates :quantity, presence: true

    class << self
        %w[eur usd btc].each do |currency|
            define_method "total_#{currency}_value" do
                CoinWallet.all.inject(0) do |sum, wallet|
                    sum += wallet.send("#{currency}_value")
                end
            end
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