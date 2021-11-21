# frozen_string_literal: true

# == Schema Information
#
# Table name: snapshots
#
#  id              :uuid             not null, primary key
#  total_usd_value :decimal(, )
#  total_eur_value :decimal(, )
#  total_btc_value :decimal(, )
#  investment_eur  :decimal(, )
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Snapshot < ApplicationRecord
  has_many :coin_snapshots, dependent: :destroy
  has_many :coins, through: :coin_snapshots

  accepts_nested_attributes_for :coin_snapshots
end
