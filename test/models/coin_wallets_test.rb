# frozen_string_literal: true

require 'test_helper'

class CoinWalletTest < ActiveSupport::TestCase
  should validate_presence_of :quantity

  context 'general total' do
    should 'compute total eur value' do
      expected = 500 * 0.930316 + 0.12 * 51190.0 + 0.2 * 51190.0 + 
                 2.1 * 3737.68 + 5.41 * 3737.68 + 207 * 0.930316 + 
                 25 * 18.34 + 125896 *0.01025913
      assert_equal expected, CoinWallet.total_eur_value
    end

    should 'compute total usd value' do
      expected = 500 * 1.05 + 0.12 * 57693.0 + 0.2 * 57693.0 + 
                 2.1 * 4212.51 + 5.41 * 4212.51 + 207 * 1.05 + 
                 25 * 20.67 + 125896 * 0.01156245
      assert_equal expected, CoinWallet.total_usd_value
    end

    should 'compute total btc value' do
      expected = 500 * 0.00001822 + 0.12 * 1.0 + 0.2 * 1.0 + 
                 2.1 * 0.07319436 + 5.41 * 0.07319436 + 207 * 0.00001822 + 
                 25 * 0.00035915 + 125896 * 0.000000201009
      assert_equal expected, CoinWallet.total_btc_value
    end
  end

  context 'compoute value' do
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
      @coin.update(market_value_usd: nil)
      assert_equal 0, @coin_wallet.usd_value

    end

    should 'compute 0 without eur market value' do
      @coin.update(market_value_eur: nil)
      assert_equal 0, @coin_wallet.eur_value
    end

    should 'compute 0 without btc market value' do
      @coin.update(market_value_btc: nil)
      assert_equal 0, @coin_wallet.btc_value
    end
  end


end