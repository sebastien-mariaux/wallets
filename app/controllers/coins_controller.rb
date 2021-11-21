# frozen_string_literal: true

class CoinsController < ApplicationController
  before_action :load_coins, only: :index
  before_action :load_coin, only: :total

  layout false, only: :total

  def new; end

  def index; end

  def create
    if Coin.create(create_params)
      redirect_to coins_path, notice: 'Success!'
    else
      render status: :unprocessable_entity
    end
  end

  def total
    currency = params['currency']
    @total_quantity = compute_total(currency)
  end

  private

  def compute_total(currency)
    return @coin.total_quantity if currency.nil?

    @currency_value = @coin.send("#{params['currency']}_value")
  end

  def create_params
    params.require(:coin).permit(:name, :code, :gecko_coin_id)
  end

  def load_coins
    @coins = Coin.all
  end

  def load_coin
    @coin = Coin.find(params[:id])
  end
end
