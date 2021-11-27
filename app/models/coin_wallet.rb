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
#
class CoinWallet < ApplicationRecord
  belongs_to :coin
  belongs_to :wallet
  belongs_to :user

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  class << self
    %w[eur usd btc].each do |currency|
      define_method "total_#{currency}_value" do
        CoinWallet.all.inject(0) do |sum, wallet|
          sum += wallet.send("#{currency}_value")
        end
      end
    end
  end

  def usd_value
    (quantity * (coin.market_value_usd || 0)).to_f
  end

  def eur_value
    (quantity * (coin.market_value_eur || 0)).to_f
  end

  def btc_value
    (quantity * (coin.market_value_btc || 0)).to_f
  end
end
