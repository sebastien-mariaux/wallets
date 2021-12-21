# frozen_string_literal: true

# == Schema Information
#
# Table name: trades
#
#  id            :uuid             not null, primary key
#  buy_coin_id   :uuid
#  sell_coin_id  :uuid
#  buy_quantity  :decimal(, )
#  sell_quantity :decimal(, )
#  date          :date
#  wallet_id     :uuid
#  user_id       :uuid
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'test_helper'

class TradeTest < ActiveSupport::TestCase
  should validate_presence_of(:buy_quantity)
  should validate_numericality_of(:buy_quantity).is_greater_than(0)
  should validate_presence_of(:sell_quantity)
  should validate_numericality_of(:sell_quantity).is_greater_than(0)

  context 'update coin wallets' do
    setup do
      @eth = coins(:eth)
      @cvx = coins(:cvx)
      @binance = wallets(:binance)
      @eth_binance = coin_wallets(:eth_binance)
      @user = users(:seba)
    end

    should 'create coin wallet' do
      assert_not CoinWallet.find_by(coin_id: @cvx.id, wallet_id: @binance.id)
      @user.trades.create!(buy_coin: @cvx, sell_coin: @eth, sell_quantity: 0.16, buy_quantity: 25, wallet: @binance)
      assert CoinWallet.find_by(coin_id: @cvx.id, wallet_id: @binance.id)
    end

    should 'update sell quantity' do
      assert_equal 2.1, @eth_binance.quantity
      @user.trades.create!(buy_coin: @cvx, sell_coin: @eth, sell_quantity: 0.16, buy_quantity: 25, wallet: @binance)
      assert_equal 2.1 - 0.16, @eth_binance.reload.quantity
    end

    should 'update sell quantity min 0' do
      @eth_binance.update!(quantity: 0)
      @user.trades.create!(buy_coin: @cvx, sell_coin: @eth, sell_quantity: 0.16, buy_quantity: 25, wallet: @binance)
      assert_equal 0, @eth_binance.reload.quantity
    end

    should 'update buy quantity' do
      cvx_binance = @user.coin_wallets.create!(coin: @cvx, wallet: @binance, quantity: 50)
      @user.trades.create!(buy_coin: @cvx, sell_coin: @eth, sell_quantity: 0.16, buy_quantity: 25, wallet: @binance)
      assert_equal 50 + 25, cvx_binance.reload.quantity
    end
  end
end
