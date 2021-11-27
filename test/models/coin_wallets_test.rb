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
      assert_equal 125896 * 0.01156245, @coin_wallet.usd_value
    end

    should 'compute eur value' do
      assert_equal 125896 * 0.01025913, @coin_wallet.eur_value
    end

    should 'compute btc value' do
      assert_equal 125896 * 0.000000201009, @coin_wallet.btc_value
    end

    should 'compute 0 without usd market value' do
      @coin.gecko_coin.update!(market_value_usd: nil)
      assert_equal 0, @coin_wallet.usd_value

    end

    should 'compute 0 without eur market value' do
      @coin.gecko_coin.update!(market_value_eur: nil)
      assert_equal 0, @coin_wallet.eur_value
    end

    should 'compute 0 without btc market value' do
      @coin.gecko_coin.update!(market_value_btc: nil)
      assert_equal 0, @coin_wallet.btc_value
    end
  end


end