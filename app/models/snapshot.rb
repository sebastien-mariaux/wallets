# frozen_string_literal: true

# == Schema Information
#
# Table name: snapshots
#
#  id              :uuid             not null, primary key
#  total_usd_value :decimal(, )
#  total_eur_value :decimal(, )
#  total_btc_value :decimal(, )
#  investment  :decimal(, )
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :uuid
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
