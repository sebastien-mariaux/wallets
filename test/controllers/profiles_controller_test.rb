# frozen_string_literal: true

require_relative './user_authenticated_controller_test'

class ProfilesControllerTest < UserAuthenticatedControllerTest

  should 'get edit' do
    get edit_profile_path
    assert_response :success
    assert_equal @logged_user, assigns(:profile)
  end

  should 'update' do
    params = {user: {investment_eur: 8000, precision: 2}}
    put profile_path, params: params
    assert_response :success
    assert_equal 2, @logged_user.reload.precision
    assert_equal 8000, @logged_user.investment_eur
  end
end