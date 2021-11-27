# frozen_string_literal: true

# == Schema Information
#
# Table name: coins
#
#  id              :uuid             not null, primary key
#  name            :string
#  code            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  gecko_coin_id   :uuid
#  reference_price :decimal(, )
#  hide            :boolean          default(FALSE)
#  user_id         :uuid
#
class Coin < ApplicationRecord
  belongs_to :gecko_coin, optional: true
  belongs_to :user

  has_many :coin_wallets
  has_many :wallets, through: :coin_wallets
  has_many :transactions

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :code, presence: true, uniqueness: { scope: :user_id }

  delegate :api_id, to: :gecko_coin

  scope :visible, lambda {
    where.not(hide: true)
  }

  def market_value_usd
    return nil if gecko_coin_id.nil?

     gecko_coin.market_value_usd
  end
  
  def market_value_eur
    return nil if gecko_coin_id.nil?

     gecko_coin.market_value_eur
  end
  
  def market_value_btc
    return nil if gecko_coin_id.nil?

     gecko_coin.market_value_btc
  end
  
  
  def display_name
    "#{name} (#{code.upcase})"
  end

  def total_quantity
    coin_wallets.inject(0) do |acc, coin_wallet|
      acc += coin_wallet.quantity
      acc
    end
  end

  def total_buy_usd
    transactions.buy.inject(0) do |sum, transaction|
      sum += transaction.usd_value
    end
  end

  def total_sell_usd
    transactions.sell.inject(0) do |sum, transaction|
      sum += transaction.usd_value
    end
  end

  def total_buy_quantity
    transactions.buy.inject(0) do |sum, transaction|
      sum += transaction.quantity
    end
  end

  def total_sell_quantity
    transactions.sell.inject(0) do |sum, transaction|
      sum += transaction.quantity
    end
  end

  def remaining_quantity
    total_buy_quantity - total_sell_quantity
  end

  def current_usd_value_in_wallet
    remaining_quantity * market_value_usd
  end

  def net_result
    current_usd_value_in_wallet + total_sell_usd - total_buy_usd
  end

  def average_buy_price
    return 0 if transactions.buy.empty?

    total_value = transactions.buy.inject(0) do |sum, transaction|
      sum += transaction.price_usd * transaction.quantity
    end
    total_value / total_buy_quantity
  end

  def average_sell_price
    return 0 if transactions.sell.empty?

    total_value = transactions.sell.inject(0) do |sum, transaction|
      sum += transaction.price_usd * transaction.quantity
    end
    total_value / total_sell_quantity
  end

  %w[usd eur btc].each do |currency|
    define_method "#{currency}_value" do
      coin_wallets.inject(0) do |sum, coin_wallet|
        sum += coin_wallet.send("#{currency}_value")
      end
    end
  end

  def variation_from_reference
    return 0 unless market_value_usd.present? && reference_price.present?

    ((market_value_usd / reference_price) - 1) * 100
  end
end
