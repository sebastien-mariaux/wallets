# frozen_string_literal: true

class AddCurrenciesToGeckoCoin < ActiveRecord::Migration[6.1]
  NEW_CURRENCIES = %w[eth ltc bch bnb eos xrp xlm lin dot yfi aed ars sat
                      aud bdt bhd bmd brl cad chf clp cny czk dkk gbp hkd huf idr
                      ils inr jpy krw kwd lkr mmk mxn myr ngn nok nzd php pkr pln rub
                      sar sek sgd thb try twd uah vef vnd zar xdr xag xau bit].freeze

  def change
    NEW_CURRENCIES.each do |curr|
      add_column :gecko_coins, "market_value_#{curr}", :decimal
    end
  end
end
