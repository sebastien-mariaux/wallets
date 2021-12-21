# frozen_string_literal: true

require 'test_helper'

class UserWealthTest < ActiveSupport::TestCase
  setup do
    @user = users(:seba)
    @user_wealth = @user.wealth
  end

  should 'compute total eur value' do
    expected = 500 * 0.930316 + 0.12 * 51_190.0 + 0.2 * 51_190.0 +
               2.1 * 3737.68 + 5.41 * 3737.68 + 207 * 0.930316 +
               25 * 18.34 + 125_896 * 0.01025913
    assert_equal expected.round(6), @user_wealth.total_value('eur').round(6)
  end

  should 'compute total usd value' do
    expected = 500 * 1.05 + 0.12 * 57_693.0 + 0.2 * 57_693.0 +
               2.1 * 4212.51 + 5.41 * 4212.51 + 207 * 1.05 +
               25 * 20.67 + 125_896 * 0.01156245
    assert_equal expected.round(6), @user_wealth.total_value('usd').round(6)
  end

  should 'compute total btc value' do
    expected = 500 * 0.00001822 + 0.12 * 1.0 + 0.2 * 1.0 +
               2.1 * 0.07319436 + 5.41 * 0.07319436 + 207 * 0.00001822 +
               25 * 0.00035915 + 125_896 * 0.000000201009
    assert_equal expected.round(6), @user_wealth.total_value('btc').round(6)
  end

  should 'compute delta' do
    @user.update!(investment: 8000, main_currency: 'eur')
    assert_equal 46_858.5936, @user_wealth.total_value('eur').round(4)
    assert_equal 485.73, @user_wealth.delta_percent.round(2)
  end

  should 'not compute delta without investment' do
    @user.update!(investment: nil, main_currency: 'eur')
    assert_equal 46_858.5936, @user_wealth.total_value('eur').round(4)
    assert_not @user_wealth.delta_percent
  end

  should 'not compute delta with 0 investment' do
    @user.update!(investment: 0, main_currency: 'eur')
    assert_equal 46_858.5936, @user_wealth.total_value('eur').round(4)
    assert_not @user_wealth.delta_percent
  end
end
