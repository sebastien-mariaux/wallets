# frozen_string_literal: true

# == Schema Information
#
# Table name: coin_snapshots
#
#  id               :uuid             not null, primary key
#  coin_id          :uuid
#  snapshot_id      :uuid
#  quantity         :decimal(, )
#  price_currency_1 :decimal(, )
#  price_currency_2 :decimal(, )
#  price_currency_3 :decimal(, )
#
class CoinSnapshot < ApplicationRecord
  belongs_to :coin
  belongs_to :snapshot

  before_create :update_data

  delegate :display_name, to: :coin
  delegate :user, to: :coin
  delegate :currency_1, to: :snapshot
  delegate :currency_2, to: :snapshot
  delegate :currency_3, to: :snapshot

  def update_data
    self.price_currency_1 = coin.market_value(currency_1)
    self.price_currency_2 = coin.market_value(currency_2)
    self.price_currency_3 = coin.market_value(currency_3)
    self.quantity = coin.total_quantity
  end
end
