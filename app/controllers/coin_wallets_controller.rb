class CoinWalletsController < ApplicationController
  layout false

  def quantity
    coin_id = params[:coin_id]
    wallet_id = params[:wallet_id]
    
    @coin_wallet = CoinWallet.find_by(coin_id: coin_id, wallet_id: wallet_id)
  end

  def total
    @total_value = case params['currency'] 
                      when 'eur'
                        CoinWallet.total_eur_value
                      when 'btc'
                        CoinWallet.total_btc_value
                      else
                        CoinWallet.total_usd_value
                      end
  end

  private
  

end