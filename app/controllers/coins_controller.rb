class CoinsController < ApplicationController
  before_action :load_coins, only: :index

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

  private

  def create_params
    params.require(:coin).permit(:name, :code, :api_id)
  end

  def load_coins
    @coins = Coin.all
  end

end