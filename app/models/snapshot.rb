# frozen_string_literal: true

# == Schema Information
#
# Table name: snapshots
#
#  id                     :uuid             not null, primary key
#  investment             :decimal(, )
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :uuid
#  currency_1             :string
#  currency_2             :string
#  currency_3             :string
#  total_value_currency_1 :decimal(, )
#  total_value_currency_2 :decimal(, )
#  total_value_currency_3 :decimal(, )
#  investment_currency    :string
#
class Snapshot < ApplicationRecord
  has_many :coin_snapshots, dependent: :destroy
  has_many :coins, through: :coin_snapshots
  belongs_to :user

  accepts_nested_attributes_for :coin_snapshots

  scope :for_currency, lambda { |currency|
    where('currency_1 = :curr OR currency_2 = :curr OR currency_3 = :curr', curr: currency)
  }

  def self.user_currencies(user)
    user.snapshots.pluck(:currency_1, :currency_2, :currency_3)
        .flatten.uniq.compact
  end

  def display_coins
    coin_list = coins.map { |coin| coin.code.upcase }
    coin_count = coins.count
    "#{coin_count} tokens (#{coin_list.join(', ')})"
  end

  def valued_in?(currency)
    [currency_1, currency_2, currency_3].include? currency
  end

  def total_value(currency)
    currency_values[currency]
  end

  def currency_values
    { currency_1 => total_value_currency_1,
      currency_2 => total_value_currency_2,
      currency_3 => total_value_currency_3 }
  end

  def delta_percent
    return 0 unless investment.positive?

    total_value_currency = total_value(investment_currency)
    return unless total_value_currency.present?

    (total_value_currency / investment - 1) * 100
  end
end
