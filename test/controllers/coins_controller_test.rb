require_relative './controllers_test'

class CoinsControllerTest < ControllersTest
  setup do
    debugger
  end

  test 'index' do
    get coins_path
    assert_response :ok
  end
end