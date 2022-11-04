# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id                       :bigint           not null, primary key
#  order_type               :string
#  coin_id                  :uuid
#  quantity                 :decimal(, )
#  date                     :date
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  imported_from            :string
#  cex_identifier           :string
#  user_id                  :uuid
#  price_reference_currency :decimal(, )
#  reference_currency       :string
#
class Transaction < ApplicationRecord
  ORDER_TYPES = %w[sell buy].freeze

  belongs_to :coin

  delegate :user, to: :coin

  validates :order_type, presence: true, inclusion: { in: ORDER_TYPES }
  validates :quantity, presence: true
  validates :price_reference_currency, presence: true
  validates :reference_currency, presence: true, inclusion: { in: SUPPORTED_CURRENCIES }

  scope :buy, -> { where(order_type: 'buy') }
  scope :sell, -> { where(order_type: 'sell') }
  scope :for_currency, ->(currency) { where(reference_currency: currency) }

  def transaction_value
    quantity * price_reference_currency
  end
end
