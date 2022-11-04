# frozen_string_literal: true

require_relative './user_authenticated_controller_test'

class CoinWalletsControllerTest < UserAuthenticatedControllerTest
  setup do
    @eth = coins(:eth)
    @binance = wallets(:binance)
    @samourai = wallets(:samourai)
    @coin_wallet = coin_wallets(:eth_binance)
  end

  should 'get quantity' do
    params = { coin_id: @eth.id, wallet_id: @binance.id }
    get quantity_coin_wallets_path, params: params
    assert_response :success
    assert_template :quantity
    assert_equal 2.1, assigns(:coin_wallet).quantity
  end

  should 'get total' do
    params = { currency: 'btc' }
    get total_coin_wallets_path, params: params
    assert_response :success
    assert_template :total
  end

  should 'create successful' do
    assert_not CoinWallet.find_by(coin_id: @eth.id, wallet_id: @samourai.id)
    params = { coin_id: @eth.id, wallet_id: @samourai.id, quantity: 5 }
    assert_difference 'CoinWallet.count', 1 do
      post create_or_update_coin_wallets_path, params: params
      assert_response :success
    end
  end

  should 'fail to create' do
    assert_not CoinWallet.find_by(coin_id: @eth.id, wallet_id: @samourai.id)
    params = { coin_id: @eth.id, wallet_id: @samourai.id, quantity: 'invalid' }
    assert_no_difference 'CoinWallet.count' do
      post create_or_update_coin_wallets_path, params: params
      assert_response :unprocessable_entity
    end
  end

  should 'update successful' do
    params = { coin_id: @coin_wallet.coin.id, wallet_id: @coin_wallet.wallet.id, quantity: 5 }
    assert_no_difference 'CoinWallet.count' do
      post create_or_update_coin_wallets_path, params: params
      assert_response :success
    end
    assert_equal 5, @coin_wallet.reload.quantity
  end
end
