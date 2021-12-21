# frozen_string_literal: true

require_relative './user_authenticated_controller_test'

class CoinsControllerTest < UserAuthenticatedControllerTest
  setup do
    @busd = coins(:busd)
    @eth = coins(:eth)
    @gecko_coin = gecko_coins(:ada)
    sign_in @logged_user
  end

  should 'index' do
    get coins_path
    assert_response :success
    assert_select 'h1', text: 'Mes cryptos'
    assert_select '.btn', text: 'Ajouter une crypto'
    assert_not assigns(:coins).include? coins(:btc_james)
  end

  should 'get new' do
    get new_coin_path
    assert_response :success
    assert_select 'h1', text: 'Nouvelle crypto'
  end

  should 'get edit' do
    get edit_coin_path(@eth)
    assert_response :success
    assert_select 'h1', text: 'Modifier Ethereum (ETH)'
  end

  should 'create successfully with gecko coin' do
    params = { coin: { gecko_coin_id: @gecko_coin.id, hide: true } }
    assert_difference 'Coin.count', 1 do
      post coins_path, params: params
      assert_response :redirect
    end
    new_coin = Coin.find_by(gecko_coin_id: @gecko_coin.id)
    assert_equal @gecko_coin.name, new_coin.name
    assert_equal @gecko_coin.code, new_coin.code
    assert new_coin.hide
  end

  should 'create successfully without gecko coin' do
    params = { coin: { name: 'some weird coin', code: 'SWC', reference_price: 10 } }
    assert_difference 'Coin.count', 1 do
      post coins_path, params: params
      assert_response :redirect
    end
    new_coin = Coin.find_by(name: 'some weird coin')
    assert_equal 'SWC', new_coin.code
    assert_equal 10, new_coin.reference_price
    assert_not new_coin.hide
  end

  should 'fail to create' do
    params = { coin: { name: 'some weird coin' } }
    assert_no_difference 'Coin.count' do
      post coins_path, params: params
      assert_response :unprocessable_entity
    end
  end

  should 'update successfully' do
    params = { coin: { hide: true, reference_price: 0.9999, name: 'biiinance' } }
    assert_no_difference 'Coin.count', 1 do
      put coin_path(@busd), params: params
      assert_response :redirect
    end
    assert_equal 'biiinance', @busd.reload.name
  end

  should 'fail to update' do
    params = { coin: { hide: true, reference_price: 0.9999, name: '' } }
    assert_no_difference 'Coin.count', 1 do
      put coin_path(@busd), params: params
      assert_response :unprocessable_entity
    end
    assert_equal 'Binance USD', @busd.reload.name
  end

  should 'get total quantity' do
    get total_coin_path(@eth)
    assert_response :success
    assert_template :total
  end

  should 'get reference price' do
    get reference_price_coin_path(@eth)
    assert_response :success
    assert_template :reference_price
  end

  should 'get market_value usd' do
    get market_value_coin_path(@eth), params: { currency: 'usd' }
    assert_response :success
    expected = { 'value' => '4212.51' }
    assert_equal expected, JSON.parse(response.body)
  end

  should 'get market_value other currency' do
    get market_value_coin_path(@eth), params: { currency: 'cad' }
    assert_response :success
    expected = { 'value' => nil }
    assert_equal expected, JSON.parse(response.body)
  end

  should 'get variation from reference' do
    get variation_from_reference_coin_path(@eth)
    assert_response :success
    assert_template :variation_from_reference
  end
end
