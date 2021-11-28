# frozen_string_literal: true

class CoinWalletsController < AuthenticatedController
  before_action :find_or_new, only: %i[create_or_update quantity]

  layout false

  def quantity; end

  def total
    @total_value = current_user.wealth.total_value(params['currency'])
  end

  def create_or_update
    if @coin_wallet.update(quantity: params[:quantity])
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def find_or_new
    @coin_wallet = current_user.coin_wallets.find_or_create_by(coin_id: params[:coin_id], wallet_id: params[:wallet_id])
  end

  def allowed_params; end
end
