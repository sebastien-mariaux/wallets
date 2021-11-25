# frozen_string_literal: true

class WalletsController < ApplicationController
  before_action :load_wallets, only: :index
  before_action :load_wallet, only: %i[edit total update]
  layout false, only: :total

  def new
    @wallet = Wallet.new
  end

  def index; end

  def edit; end

  def create
    @wallet = Wallet.create(allowed_params)
    if @wallet.save
      redirect_to wallets_path, notice: 'Success!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @wallet.update(allowed_params)
      redirect_to coins_path, notice: 'Success!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def total
    @currency_value = @wallet.send("#{params['currency']}_value")
  end

  private

  def allowed_params
    params.require(:wallet).permit(:name, :description)
  end

  def load_wallets
    @wallets = Wallet.all
  end

  def load_wallet
    @wallet = Wallet.find(params[:id])
  end
end
