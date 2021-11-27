# frozen_string_literal: true

# == Schema Information
#
# Table name: coins
#
#  id               :uuid             not null, primary key
#  name             :string
#  code             :string
#  market_value_usd :decimal(, )
#  market_value_eur :decimal(, )
#  market_value_btc :decimal(, )
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  gecko_coin_id    :uuid
#  reference_price  :decimal(, )
#  hide             :boolean          default(FALSE)
#
require 'test_helper'

class CoinTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:code)
  should validate_uniqueness_of(:name)
  should validate_uniqueness_of(:code)

  should 'scope' do
    visible_coin = coins(:cvx)
    hidden_coin = coins(:busd)
    visible = Coin.visible
    assert_not visible.include?(hidden_coin)
    assert visible.include?(visible_coin)
  end

  context 'compute totals' do
    setup do
      @eth = coins(:eth)
      assert_equal 2.1, coin_wallets(:eth_binance).quantity
      assert_equal 5.41, coin_wallets(:eth_ledger).quantity
      assert_equal 2, coins(:eth).wallets.count
    end

    should 'compute total quantity' do
      expected = 2.1 + 5.41
      assert_equal expected, @eth.total_quantity
    end

    should 'compute usd_value' do
      expected = (2.1 + 5.41) * 4212.51
      assert_equal expected.round(4), @eth.usd_value.round(4)
    end

    should 'compute eur value' do
      expected = (2.1 + 5.41) * 3737.68
      assert_equal expected.round(4), @eth.eur_value.round(4)
    end

    should 'compute btc value' do
      expected = (2.1 + 5.41) * 0.07319436
      assert_equal expected.round(4), @eth.btc_value.round(4)
    end
  end

  context 'compute variation from reference' do
    should 'return 0 without market value' do
      coin = coins(:xrp)
      coin.update(reference_price: 10, market_value_usd: nil)
      assert_equal 0, coin.variation_from_reference
    end

    should 'return 0 without reference price' do
      coin = coins(:xrp)
      coin.update(reference_price: nil, market_value_usd: 1.05)
      assert_equal 0, coin.variation_from_reference
    end

    should 'return variation' do
      coin = coins(:xrp)
      coin.update(reference_price: 1, market_value_usd: 1.05)
      assert_equal 5, coin.variation_from_reference
    end
  end
end
