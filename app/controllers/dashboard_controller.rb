class DashboardController < ApplicationController
    before_action :load_data, only: :home

    def home
    end

    private

    def load_data
        @coins = Coin.all
        @wallets = Wallet.all
        @coin_wallets = CoinWallet.all
    end

    #def load_data
    #    @data = {}
    #    Coin.all.map do |coin|
    #        Wallet.all.map do |wallet|
    #            @data[coin.id] = {
    #                wallet.id => coin_wallet(coin, wallet)
    #            }
    #        end
    #    end
    #end
#
    #def coin_wallet(coin, wallet)
    #    CoinWallet.where()
    #end
end
