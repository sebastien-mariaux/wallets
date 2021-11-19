class WalletsController < ApplicationController
  before_action :load_wallets, only: :index
  before_action :load_wallet, only: :total
  layout false, only: :total

  def new
  end

  def index
  end

  def create
    if Wallet.create(create_params)
      redirect_to wallets_path, notice: 'Success!'
    else
      render status: :unprocessable_entity
    end
  end

  def total
    @currency_value = @wallet.send("#{params['currency']}_value")  
  end

  private

  def create_params
    params.require(:wallet).permit(:name, :description)
  end

  def load_wallets
    @wallets = Wallet.all
  end

  def load_wallet
    @wallet = Wallet.find(params[:id])
  end

end