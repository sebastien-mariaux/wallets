# frozen_string_literal: true

require_relative './user_authenticated_controller_test'

class WalletsControllerTest < UserAuthenticatedControllerTest
  setup do
    @binance = wallets(:binance)
    @coinbase = wallets(:coinbase)
  end

  should 'index' do
    get wallets_path
    assert_response :success
    assert_select 'h1', text: 'Mes Plateformes'
    assert_select '.btn', text: 'Nouvelle plateforme'
    assert_not assigns(:wallets).include? wallets(:james_binance)
  end

  should 'get new' do
    get new_wallet_path
    assert_response :success
    assert_select 'h1', text: 'Nouvelle plateforme'
  end

  should 'get edit' do
    get edit_wallet_path(@binance)
    assert_response :success
    assert_select 'h1', text: 'Modifier Binance'
  end

  should 'create successfully' do
    params = { wallet: { name: 'Wallawallet', description: 'Un wallet pour HBAR' } }
    assert_difference 'Wallet.count', 1 do
      post wallets_path, params: params
      assert_response :redirect
    end
  end

  should 'fail to create' do
    params = { wallet: { description: 'Un wallet pour HBAR' } }
    assert_no_difference 'Wallet.count' do
      post wallets_path, params: params
      assert_response :unprocessable_entity
    end
  end

  should 'update wallet' do
    params = { wallet: { description: 'new description' } }
    assert_no_difference 'Wallet.count' do
      put wallet_path(@binance), params: params
      assert_response :redirect
    end
    assert_equal 'new description', @binance.reload.description
  end

  should 'get total' do
    coinbase_eur_value = 207 * 0.930316
    get total_wallet_path(@coinbase), params: { currency: 'eur' }
    assert_response :success
    assert_template :total
    assert_equal coinbase_eur_value, assigns(:currency_value)
  end
end
