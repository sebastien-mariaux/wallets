# frozen_string_literal: true

class CoinsController < ApplicationController
  before_action :load_coins, only: :index
  before_action :load_coin, only: %i[total edit update reference_price]

  layout false, only: %i[total reference_price]

  def new
    @coin = Coin.new
  end

  def index; end

  def edit; end

  def update
    if @coin.update(allowed_params)
      redirect_to coins_path, notice: 'Success!'
    else
      render status: :unprocessable_entity
    end
  end

  def create  
    if Coin.create(allowed_params)
      redirect_to coins_path, notice: 'Success!'
    else
      render status: :unprocessable_entity
    end
  end

  def total
    currency = params['currency']
    @total_quantity = compute_total(currency)
  end

  def reference_price
  end

  private

  def compute_total(currency)
    return @coin.total_quantity if currency.nil?

    @currency_value = @coin.send("#{params['currency']}_value")
  end

  def allowed_params
    params.require(:coin).permit(:name, :code, :gecko_coin_id, :reference_price, :hide)
  end

  def load_coins
    @coins = Coin.order(:name)
  end

  def load_coin
    @coin = Coin.find(params[:id])
  end
end
