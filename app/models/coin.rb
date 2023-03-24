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
  belongs_to :gecko_coin
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

  def trades
    user.trades.where("buy_coin_id = :id or sell_coin_id = :id", id: id)
  end

  def transaction_currencies
    transactions.pluck(:reference_currency).uniq
  end

  def market_value(currency)
    return nil if gecko_coin_id.nil? || currency.blank?

    gecko_coin.send("market_value_#{currency}")
  end

  def display_name
    "#{name} (#{code.upcase})"
  end

  def display_code
    "#{code.upcase} (#{name})"
  end

  def total_quantity
    coin_wallets.inject(0) do |acc, coin_wallet|
      acc += coin_wallet.quantity
      acc
    end
  end

  def total_buy_quantity
    buy_transactions.inject(0) do |sum, transaction|
      sum += transaction.quantity
    end
  end

  def total_investment
    buy_transactions.inject(0) do |sum, transaction|
      sum += transaction.price_reference_currency * transaction.quantity
    end
  end

  def total_sold_value
    sell_transactions.inject(0) do |sum, transaction|
      sum += transaction.price_reference_currency * transaction.quantity
    end
  end

  def total_sell_quantity
    sell_transactions.inject(0) do |sum, transaction|
      sum += transaction.quantity
    end
  end

  def total_buy_quantity
    buy_transactions.inject(0) do |sum, transaction|
      sum += transaction.quantity
    end
  end

  def total_sell_quantity
    sell_transactions.inject(0) do |sum, transaction|
      sum += transaction.quantity
    end
  end

  def remaining_quantity
    total_buy_quantity - total_sell_quantity
  end

  def current_value_in_wallet(currency)
    remaining_quantity * market_value(currency)
  end

  def net_result
    current_value_in_wallet(user.main_currency) + total_sold_value - total_investment
  end

  def average_buy_price
    return 0 if buy_transactions.empty?

    total_investment / total_buy_quantity
  end

  def average_sell_price
    return 0 if sell_transactions.empty?

    total_sold_value / total_sell_quantity
  end

  # def average_sell_price
  #   return 0 if transactions.sell.empty?

  #   total_value = transactions.sell.inject(0) do |sum, transaction|
  #     sum += transaction.price_usd * transaction.quantity
  #   end
  #   total_value / total_sell_quantity
  # end

  def currency_value(currency)
    coin_wallets.inject(0) do |sum, coin_wallet|
      sum += coin_wallet.currency_value(currency)
    end
  end

  def variation_from_reference
    return 0 unless market_value(user.main_currency).present? && reference_price.present?

    ((market_value(user.main_currency) / reference_price) - 1) * 100
  end

  private

  def buy_transactions
    @buy_transactions ||= transactions.buy.for_currency(user.main_currency)
  end

  def sell_transactions
    @sell_transactions ||= transactions.sell.for_currency(user.main_currency)
  end
end
