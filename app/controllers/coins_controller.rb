class CoinsController < ApplicationController
  before_action :load_coins, only: :index
  before_action :load_coin, only: :total

  layout false, only: :total

  def new
  end

  def index
  end

  def create
    if Coin.create(create_params)
      redirect_to coins_path, notice: 'Success!'
    else
      render status: :unprocessable_entity
    end
  end

  def total
    @total_quantity = @coin.total_quantity
  end

  private

  def create_params
    params.require(:coin).permit(:name, :code, :api_id)
  end

  def load_coins
    @coins = Coin.all
  end

  def load_coin
    @coin = Coin.find(params[:id])
  end

end