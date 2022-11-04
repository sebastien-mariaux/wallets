# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # https://api.coingecko.com/api/v3/simple/supported_vs_currencies
  SUPPORTED_CURRENCIES = %w[btc eth ltc bch bnb eos xrp xlm lin dot yfi usd aed ars sat
                            aud bdt bhd bmd brl cad chf clp cny czk dkk eur gbp hkd huf idr
                            ils inr jpy krw kwd lkr mmk mxn myr ngn nok nzd php pkr pln rub
                            sar sek sgd thb try twd uah vef vnd zar xdr xag xau bit].freeze
end
