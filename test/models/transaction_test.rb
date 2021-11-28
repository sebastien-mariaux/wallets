
require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  should validate_presence_of :order_type
  should validate_inclusion_of(:order_type).in_array(%w[sell buy])
  should validate_presence_of :price_usd
  should validate_presence_of :quantity

  should 'scope buy' do
    assert_equal 3, coins(:xrp).transactions.buy.count
  end

  should 'scope sell' do
    assert_equal 2, coins(:xrp).transactions.sell.count
  end
end