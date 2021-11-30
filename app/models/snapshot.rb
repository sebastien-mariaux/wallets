# frozen_string_literal: true

# == Schema Information
#
# Table name: snapshots
#
#  id                     :uuid             not null, primary key
#  investment_eur         :decimal(, )
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :uuid
#  currency_1             :string
#  currency_2             :string
#  currency_3             :string
#  total_value_currency_1 :decimal(, )
#  total_value_currency_2 :decimal(, )
#  total_value_currency_3 :decimal(, )
#
class Snapshot < ApplicationRecord
  has_many :coin_snapshots, dependent: :destroy
  has_many :coins, through: :coin_snapshots
  belongs_to :user

  accepts_nested_attributes_for :coin_snapshots

  def display_coins
    coin_list = coins.map { |coin| coin.code.upcase }
    coin_count = coins.count
    "#{coin_count} tokens (#{coin_list.join(', ')})"
  end
end
