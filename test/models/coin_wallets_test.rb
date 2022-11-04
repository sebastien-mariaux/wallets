# frozen_string_literal: true

require 'test_helper'

class CoinWalletTest < ActiveSupport::TestCase
  should validate_presence_of :quantity

  context 'compute value' do
    setup do
      @coin_wallet = coin_wallets(:stak_binance)
      @coin = coins(:stak)
    end

    should 'compute usd value' do
      assert_equal 125_896 * 0.01156245, @coin_wallet.currency_value('usd')
    end

    should 'compute eur value' do
      assert_equal 125_896 * 0.01025913, @coin_wallet.currency_value('eur')
    end

    should 'compute btc value' do
      assert_equal 125_896 * 0.000000201009, @coin_wallet.currency_value('btc')
    end

    should 'compute 0 without usd market value' do
      @coin.gecko_coin.update!(market_value_usd: nil)
      assert_equal 0, @coin_wallet.currency_value('usd')
    end

    should 'compute 0 without eur market value' do
      @coin.gecko_coin.update!(market_value_eur: nil)
      assert_equal 0, @coin_wallet.currency_value('eur')
    end

    should 'compute 0 without btc market value' do
      @coin.gecko_coin.update!(market_value_btc: nil)
      assert_equal 0, @coin_wallet.currency_value('btc')
    end
  end
end
