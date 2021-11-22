class TransactionsController < ApplicationController
  before_action :load_coin
  before_action :load_transactions, only: :index

  def index
  end

  def new
  end

  def create
    @transaction = @coin.transactions.new(allowed_params)
    if @transaction.save
      redirect_to coin_transactions_path(@coin)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def allowed_params
    params.require(:transaction).permit(:date, :order_type, :quantity, :price_usd)
  end

  def load_coin
    @coin = Coin.find(params[:coin_id])
  end

  def load_transactions
    @transactions = @coin.transactions
  end
end