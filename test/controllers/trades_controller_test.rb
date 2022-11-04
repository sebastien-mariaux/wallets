# frozen_string_literal: true

require_relative './user_authenticated_controller_test'

class TradesControllerTest < UserAuthenticatedControllerTest
  setup do
    @xrp = coins(:xrp)
    @busd = coins(:busd)
    @wallet = wallets(:binance)
  end

  should 'create' do
    params = { trade: {
      date: Date.current, wallet_id: @wallet.id, buy_coin_id: @xrp.id,
      sell_coin_id: @busd.id, buy_quantity: 110, sell_quantity: 120
    } }
    assert_difference 'Trade.count', 1 do
      post trades_path, params: params
      assert_response :success
    end
    assert_equal Trade.order(:created_at).last.user, @logged_user
  end

  should 'fail to create' do
    params = { trade: {
      date: Date.current, wallet_id: @wallet.id, buy_coin_id: nil,
      sell_coin_id: @busd.id, buy_quantity: 110, sell_quantity: 120
    } }
    assert_no_difference 'Trade.count' do
      post trades_path, params: params
      assert_response :unprocessable_entity
    end
  end

  should 'get index' do
    get coin_trades_path(@xrp)
    assert_response :success
  end
end
