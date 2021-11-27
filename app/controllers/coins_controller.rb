# frozen_string_literal: true

class CoinsController < ApplicationController
  before_action :load_coins, only: :index
  before_action :load_coin, only: %i[total edit update reference_price
                                     market_value_usd variation_from_reference]

  layout false, only: %i[total reference_price market_value_usd variation_from_reference]

  def new
    @coin = Coin.new
  end

  def index; end

  def edit; end

  def update
    if @coin.update(allowed_params)
      redirect_to coins_path, notice: 'Success!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @coin = Coin.new(allowed_params)
    set_name_and_code
    if @coin.save
      redirect_to coins_path, notice: 'Success!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def total
    currency = params['currency']
    @total_quantity = compute_total(currency)
  end

  def reference_price; end

  def market_value_usd
    value = @coin.market_value_usd.round(@config.precision)

    render json: { value: value }
  end

  def variation_from_reference; end

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

  def set_name_and_code
    return if @coin.gecko_coin.nil?

    @coin.name = @coin.gecko_coin.name if @coin.name.nil?
    @coin.code = @coin.gecko_coin.code if @coin.code.nil?
  end
end
