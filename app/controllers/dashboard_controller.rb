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
end
