# frozen_string_literal: true

module DashboardHelper
  def total_variation
    delta = (CoinWallet.total_eur_value / Config.first.investment_eur - 1) * 100
    direction = delta >= 0 ? 'green' : 'red'
    tag.span class: direction do
      "#{number_with_precision(delta, precision: 2)} %"
    end
  end

  def variation_from_reference(coin)
    delta = coin.variation_from_reference
    klass = delta >= 0 ? 'green' : 'red'
    tag.span(class: klass) do
     "#{ number_with_precision delta, precision: 2} %"
    end
  end

  def get_quantity(coin_wallets, coin_id, wallet_id)
    coin_wallet = coin_wallets.find do |cw| 
      cw.coin_id == coin_id && cw.wallet_id == wallet_id
    end
    quantity = coin_wallet&.quantity || 0
    quantity > 0 ? quantity : '-' 
  end
end
