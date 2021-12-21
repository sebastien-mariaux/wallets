# frozen_string_literal: true

class DashboardController < AuthenticatedController
  before_action :load_data, only: %i[home]
  before_action :load_coins, only: %i[home chart_data]

  layout false, only: :summary

  def home; end

  def chart_data
    render json: generate_chart_data
  end

  def summary; end

  private

  def generate_chart_data
    coins = @coins.all.sort_by { |coin| coin.currency_value(@main_currency) }
    {
      labels: compute_labels(coins),
      values: compute_values(coins)
    }
  end

  def compute_labels(coins)
    coins.pluck(:name)
  end

  def compute_values(coins)
    total_value = current_user.wealth.total_value(@main_currency)
    coins.map { |coin| (coin.currency_value(@main_currency) / total_value * 100).round(2) }
  end

  def load_data
    @wallets = current_user.wallets.order(:name)
    @coin_wallets = current_user.coin_wallets.all
  end

  def load_coins
    @coins = current_user.coins.order(:name)
    @coins = @coins.visible unless params[:display_all]
  end
end
