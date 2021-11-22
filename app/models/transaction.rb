class Transaction < ApplicationRecord
  ORDER_TYPES = %w[sell buy]

  belongs_to :coin

  validates :order_type, presence: true, inclusion: {in: ORDER_TYPES}
  validates :quantity, presence: true
  validates :price_usd, presence: true

end