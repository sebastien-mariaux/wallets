# frozen_string_literal: true

class CoinsController < AuthenticatedController
  before_action :load_coins, only: %i[new index create]
  before_action :load_coin, only: %i[total edit update reference_price
                                     market_value variation_from_reference]

  layout false, only: %i[total reference_price market_value variation_from_reference]

  def new
    @coin = @coins.new
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
    @coin = @coins.new(allowed_params)
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

  def market_value
    value = @coin.market_value(params['currency'])&.round(current_user.precision)

    render json: { value: value }
  end

  def variation_from_reference; end

  private

  def compute_total(currency)
    return @coin.total_quantity if currency.nil?

    @currency_value = @coin.currency_value(params['currency'])
  end

  def allowed_params
    params.require(:coin).permit(:name, :code, :gecko_coin_id, :reference_price, :hide)
  end

  def load_coins
    @coins = current_user.coins.order(:name)
  end

  def load_coin
    @coin = current_user.coins.find(params[:id])
  end

  def set_name_and_code
    return if @coin.gecko_coin.nil?

    @coin.name = @coin.gecko_coin.name if @coin.name.nil?
    @coin.code = @coin.gecko_coin.code if @coin.code.nil?
  end
end
