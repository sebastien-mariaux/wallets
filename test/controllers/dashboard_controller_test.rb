# frozen_string_literal: true

require_relative './user_authenticated_controller_test'

class DashboardControllerTest < UserAuthenticatedControllerTest
  context 'home' do
    should 'render with success' do
      get root_path
      assert_response :success
    end

    should 'load visible coins' do
      get root_path
      coins = assigns(:coins)
      assert coins.include?(coins(:eth))
      assert_not coins.include?(coins(:busd))
      assert_not coins.include?(coins(:btc_james))
    end

    should 'load all coins' do
      get root_path(display_all: true)
      coins = assigns(:coins)
      assert coins.include?(coins(:eth))
      assert coins.include?(coins(:busd))
      assert_not coins.include?(coins(:btc_james))
    end

    should 'load wallets' do
      get root_path
      wallets = assigns(:wallets)
      assert wallets.include?(wallets(:binance))
      assert wallets.include?(wallets(:ledger))
      assert_not wallets.include?(wallets(:james_binance))
    end

    should 'load coinwallets' do
      get root_path
      coin_wallets = assigns(:coin_wallets)
      assert coin_wallets.include?(coin_wallets(:btc_samourai))
      assert coin_wallets.include?(coin_wallets(:eth_binance))
      assert_not coin_wallets.include?(coin_wallets(:james_btc))
    end
  end

  should 'get summary' do
    get summary_dashboard_path
    assert_response :success
    assert_template :summary
  end

  should 'chart data' do
    get chart_data_dashboard_path
    assert_response :success
    assert_equal %w[labels values], JSON.parse(response.body).keys
  end
end
