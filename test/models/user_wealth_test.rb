
class UserWealthTest < ActiveSupport::TestCase
  setup do
    @user = users(:seba)
    @user_wealth = @user.wealth
  end

  should 'compute total eur value' do
    expected = 500 * 0.930316 + 0.12 * 51190.0 + 0.2 * 51190.0 + 
                2.1 * 3737.68 + 5.41 * 3737.68 + 207 * 0.930316 + 
                25 * 18.34 + 125896 *0.01025913
    assert_equal expected, @user_wealth.total_eur_value
  end

  should 'compute total usd value' do
    expected = 500 * 1.05 + 0.12 * 57693.0 + 0.2 * 57693.0 + 
                2.1 * 4212.51 + 5.41 * 4212.51 + 207 * 1.05 + 
                25 * 20.67 + 125896 * 0.01156245
    assert_equal expected, @user_wealth.total_usd_value
  end

  should 'compute total btc value' do
    expected = 500 * 0.00001822 + 0.12 * 1.0 + 0.2 * 1.0 + 
                2.1 * 0.07319436 + 5.41 * 0.07319436 + 207 * 0.00001822 + 
                25 * 0.00035915 + 125896 * 0.000000201009
    assert_equal expected, @user_wealth.total_btc_value
  end
  
end