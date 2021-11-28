
require 'test_helper'

class GeckoCoinTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should validate_presence_of :code
  should validate_presence_of :api_id
  should validate_uniqueness_of(:api_id)

  context 'search' do
    should 'fail search by name' do
      assert_equal 0, GeckoCoin.search('Cardano').count
    end

    should 'succeed by code' do
      assert_equal 1, GeckoCoin.search('ADA').count
    end

    should 'succeed by partial code' do
      assert_equal 2, GeckoCoin.search('b').count
    end
  end

  should 'get applied gecko coins' do
    applied = GeckoCoin.applied
    assert gecko_coins(:ada).coins.empty?
    assert_not applied.include? gecko_coins(:ada)
    assert gecko_coins(:eth).coins.present?
    assert applied.include? gecko_coins(:eth)
  end
end