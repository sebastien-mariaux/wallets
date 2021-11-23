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
    quantity = coin_wallet&.quantity
    format_number(quantity)
  end

  def get_wallet_total(wallets, wallet_id, currency)
    value = wallets.find{ |wallet| wallet.id == wallet_id }&.send("#{currency}_value")
    format_number(value)
  end

  def get_coin_total(coins, coin_id, currency)
    coin = coins.find{ |coin| coin.id == coin_id }
    value = if currency
            coin&.send("#{currency}_value")
          else
            coin.total_quantity
          end
    format_number(value)
  end

  def get_main_total(coin_wallets, currency)
    total = coin_wallets.send("total_#{currency}_value")
    format_number(total)
  end

  def format_number(value, precision: nil)
    formatted_value = (value || 0) > 0 ? value : '-' 
    number_with_precision formatted_value, precision: precision || default_precision
  end

  def default_precision
    Config.fetch.precision
  end
end
