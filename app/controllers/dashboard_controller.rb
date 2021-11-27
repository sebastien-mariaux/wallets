# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :load_data, only: %i[home]
  before_action :load_summary_data, only: %i[home summary]

  layout false, only: :summary

  def home; end

  def chart_data
    render json: generate_chart_data
  end

  def summary; end

  private

  def generate_chart_data
    coins = Coin.all.sort_by(&:usd_value)
    {
      labels: compute_labels(coins),
      values: compute_values(coins)
    }
  end

  def load_summary_data
    @config = Config.fetch
    @total_value = CoinWallet.total_eur_value
  end

  def compute_labels(coins)
    coins.pluck(:name)
  end

  def compute_values(coins)
    total_value = CoinWallet.total_usd_value
    coins.map { |coin| (coin.usd_value / total_value * 100).round(2) }
  end

  def load_data
    @coins = Coin.order(:name)
    @coins = @coins.visible unless params[:display_all]
    @wallets = Wallet.order(:name)
    @coin_wallets = CoinWallet.all
  end
end
