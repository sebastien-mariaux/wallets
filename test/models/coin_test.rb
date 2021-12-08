# frozen_string_literal: true

# == Schema Information
#
# Table name: coins
#
#  id              :uuid             not null, primary key
#  name            :string
#  code            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  gecko_coin_id   :uuid
#  reference_price :decimal(, )
#  hide            :boolean          default(FALSE)
#  user_id         :uuid
#
require 'test_helper'

class CoinTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:code)
  should validate_uniqueness_of(:name).scoped_to(:user_id)
  should validate_uniqueness_of(:code).scoped_to(:user_id)

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
      assert_equal expected.round(4), @eth.currency_value('usd').round(4)
    end

    should 'compute eur value' do
      expected = (2.1 + 5.41) * 3737.68
      assert_equal expected.round(4), @eth.currency_value('eur').round(4)
    end

    should 'compute btc value' do
      expected = (2.1 + 5.41) * 0.07319436
      assert_equal expected.round(4), @eth.currency_value('btc').round(4)
    end
  end

  context 'compute variation from reference' do
    should 'return 0 without market value' do
      coin = coins(:xrp)
      assert_equal 0, coin.variation_from_reference
    end

    should 'return 0 without reference price' do
      coin = coins(:xrp)
      assert_equal 0, coin.variation_from_reference
    end

    should 'return variation' do
      coin = coins(:xrp)
      coin.update!(reference_price: 1)
      coin.gecko_coin.update!(market_value_eur: 1.05)
      assert_equal 5, coin.variation_from_reference
    end
  end

  context 'transactions' do
    setup do
      skip("Rewrite test after transaction rework")
      @xrp = coins(:xrp)
      @cvx = coins(:cvx) 
      assert_equal 5, @xrp.transactions.count
      assert_equal 0, @cvx.transactions.count
    end

    should 'compute total buy quantity with transactions' do
      assert_equal 700, @xrp.total_buy_quantity
    end

    should 'compute total sell quantity with transactions' do
      assert_equal 200, @xrp.total_sell_quantity
    end

    should 'compute total buy with transactions' do
      expected = 0.95 * 100 + 1.1 * 200 + 0.85 * 400
      assert_equal expected, @xrp.total_buy_usd
    end

    should 'compute total sell with transactions' do
      expected = 1.3 * 50 + 1.2 * 150
      assert_equal expected, @xrp.total_sell_usd
    end

    should 'compute remaining quantity' do
      assert_equal 500, @xrp.remaining_quantity
    end

    should 'compute current value' do
      assert_equal 1.05, gecko_coins(:xrp).market_value_usd
      assert_equal 500 * 1.05, @xrp.current_usd_value_in_wallet
    end

    should 'compute net result' do
      #total sell + current value - investment
      expected = 245 + 500 * 1.05 - 655
      assert_equal expected, @xrp.net_result
    end

    should 'compute all without transactions' do
      assert_equal 0, @cvx.total_buy_usd
      assert_equal 0, @cvx.total_sell_usd
      assert_equal 0, @cvx.total_buy_quantity
      assert_equal 0, @cvx.total_sell_quantity
      assert_equal 0, @cvx.remaining_quantity
      assert_equal 0, @cvx.current_usd_value_in_wallet
      assert_equal 0, @cvx.net_result
      assert_equal 0, @cvx.average_buy_price
      assert_equal 0, @cvx.average_sell_price
    end
  end
end
