class CoinWalletsController < ApplicationController
  layout false

  def quantity
    coin_id = params[:coin_id]
    wallet_id = params[:wallet_id]
    
    @coin_wallet = CoinWallet.find_by(coin_id: coin_id, wallet_id: wallet_id)
  end

  def total
    @total_value = CoinWallet.send("total_#{params['currency']}_value")
  end

  private
  

end