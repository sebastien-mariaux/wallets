class DashboardController < ApplicationController
  before_action :load_data, only: :home

  def home
    @config = Config.first
    @total_value = CoinWallet.total_eur_value
  end

  private

  def load_data
    @coins = Coin.all
    @wallets = Wallet.all
    @coin_wallets = CoinWallet.all
  end
end
