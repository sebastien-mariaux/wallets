# frozen_string_literal: true

require_relative './user_authenticated_controller_test'

class GeckoCoinsControllerTest < UserAuthenticatedControllerTest
  should 'search' do
    get search_gecko_coins_path, params: { query: 'sta' }
    assert_response :success
    assert_template :search
    assert_equal 1, assigns(:results).count
    assert_equal gecko_coins(:stak), assigns(:results).first
  end
end
