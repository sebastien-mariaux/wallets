# frozen_string_literal: true

require_relative './controllers_test'

class UserAuthenticatedControllerTest < ControllersTest
  include Devise::Test::IntegrationHelpers

  setup do
    @logged_user = users(:seba)
    sign_in @logged_user
  end
end
