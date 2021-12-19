require "test_helper"

class TradeTest < ActiveSupport::TestCase
  should validate_presence_of(:buy_quantity)
  should validate_numericality_of(:buy_quantity).is_greater_than(0)
  should validate_presence_of(:sell_quantity)
  should validate_numericality_of(:sell_quantity).is_greater_than(0)
end
