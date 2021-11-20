class DashboardController < ApplicationController
  before_action :load_data, only: :home

  def home
    @config = Config.first
    @total_value = CoinWallet.total_eur_value
  end

  def chart_data
    render json: generate_chart_data
  end

  private

  def generate_chart_data
    coins = Coin.all
    {
      labels: compute_labels(coins),
      values: compute_values(coins)
    }
  end

  def compute_labels(coins)
    coins.pluck(:name)
  end

  def compute_values(coins)
    total_value = CoinWallet.total_usd_value
    coins.map{|coin| (coin.usd_value / total_value * 100).round(2)}
  end

  def load_data
    @coins = Coin.all
    @wallets = Wallet.all
    @coin_wallets = CoinWallet.all
  end
end
