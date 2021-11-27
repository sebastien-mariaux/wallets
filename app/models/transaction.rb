# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id             :bigint           not null, primary key
#  order_type     :string
#  coin_id        :uuid
#  quantity       :decimal(, )
#  price_usd      :decimal(, )
#  date           :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  imported_from  :string
#  cex_identifier :string
#  user_id        :uuid
#
class Transaction < ApplicationRecord
  ORDER_TYPES = %w[sell buy].freeze

  belongs_to :user
  belongs_to :coin

  validates :order_type, presence: true, inclusion: { in: ORDER_TYPES }
  validates :quantity, presence: true
  validates :price_usd, presence: true

  scope :buy, -> { where(order_type: 'buy') }
  scope :sell, -> { where(order_type: 'sell') }

  def usd_value
    price_usd * quantity
  end
end
