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
  end
end