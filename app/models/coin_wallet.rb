# frozen_string_literal: true

# == Schema Information
#
# Table name: coin_wallets
#
#  id         :uuid             not null, primary key
#  coin_id    :uuid
#  wallet_id  :uuid
#  quantity   :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid
#
class CoinWallet < ApplicationRecord
  belongs_to :coin
  belongs_to :wallet
  belongs_to :user

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  class << self
  end

  def currency_value(currency)
    (quantity * (coin.market_value(currency) || 0)).to_f
  end

  # def usd_value
  #   (quantity * (coin.market_value_usd || 0)).to_f
  # end

  # def eur_value
  #   (quantity * (coin.market_value_eur || 0)).to_f
  # end

  # def btc_value
  #   (quantity * (coin.market_value_btc || 0)).to_f
  # end
end
