class CoinSnapshot < ApplicationRecord
  belongs_to :coin
  belongs_to :snapshot

  before_create :update_data

  def update_data
    self.quantity = coin.total_quantity
    self.usd_price = coin.market_value_usd
    self.eur_price = coin.market_value_eur
  end
end