# frozen_string_literal: true

class TradesController < AuthenticatedController
  layout false, only: :create

  def create
    @trade = current_user.trades.new(allowed_params)
    if @trade.save
      @trade.buy_quantity = 0
      @trade.sell_quantity = 0
      head :ok
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def allowed_params
    params.require(:trade)
          .permit(:buy_coin_id, :sell_coin_id, :wallet_id, :buy_quantity, :sell_quantity, :date)
  end
end
