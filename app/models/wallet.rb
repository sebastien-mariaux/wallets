class Wallet < ApplicationRecord
    has_many :coin_wallets
    has_many :coins, through: :coin_wallets
    validates :name, presence: true, uniqueness: true

    def usd_value
        coin_wallets.inject(0) do |sum, coin_wallet|
            sum += coin_wallet.usd_value
        end
    end

    def eur_value
        coin_wallets.inject(0) do |sum, coin_wallet|
            sum += coin_wallet.eur_value
        end
    end

    def btc_value
        coin_wallets.inject(0) do |sum, coin_wallet|
            sum += coin_wallet.btc_value
        end
    end
end