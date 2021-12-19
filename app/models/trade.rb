class Trade < ApplicationRecord
  belongs_to :buy_coin, class_name: 'Coin'
  belongs_to :sell_coin, class_name: 'Coin'
  belongs_to :wallet
  belongs_to :user

  validates :buy_quantity, presence: true
  validates :sell_quantity, presence: true
  validates_numericality_of :buy_quantity, greater_than: 0
  validates_numericality_of :sell_quantity, greater_than: 0
end
