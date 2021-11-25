require_relative './controllers_test'

class CoinsControllerTest < ControllersTest
  setup do
    @busd = coins(:busd)
    @eth = coins(:eth)
  end

  context 'index' do
    setup do
      
    end
    
    should  'succeed' do
      get coins_path
      assert_response :ok
    end

    should 'display all coins' do
      get coins_path(display_all: true)
      coins = assigns(:coins)
      assert coins.include? @busd
      assert coins.include? @eth
    end

    should 'not display hidden coins' do
      get coins_path
      coins = assigns(:coins)
      assert_not coins.include? @busd
      assert coins.include? @eth
    end
  end
  
end