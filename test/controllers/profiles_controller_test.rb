# frozen_string_literal: true

require_relative './user_authenticated_controller_test'

class ProfilesControllerTest < UserAuthenticatedControllerTest

  should 'get edit' do
    get edit_profile_path
    assert_response :success
    assert_equal @logged_user, assigns(:profile)
  end

  should 'update' do
    params = {user: {investment: 8000, precision: 2, main_currency: 'cad', 
              display_usd: true, display_btc: false, display_local: true}}
    put profile_path, params: params
    assert_response :success
    assert_equal 2, @logged_user.reload.precision
    assert_equal 8000, @logged_user.investment
    assert_equal true,  @logged_user.display_usd
    assert_equal false,  @logged_user.display_btc
    assert_equal true,  @logged_user.display_local
    assert_equal 'cad', @logged_user.main_currency
  end
end