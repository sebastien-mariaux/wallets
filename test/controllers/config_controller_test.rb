# frozen_string_literal: true

require_relative './controllers_test'

class ConfigControllerTest < ControllersTest
  should 'show' do
    get config_path
    assert_response :success
    assert_select 'h1', text: 'Configuration'
    assert_select '.btn', text: 'Modifier'
  end

  should 'get edit' do
    get edit_config_path
    assert_response :success
    assert_select 'h1', text: 'Modifier la configuration'
  end

  should 'create' do
    params = { config: { investment_eur: 10_000, precision: 4 } }
    assert_difference 'Config.count', 1 do
      put config_path, params: params
      assert_response :redirect
    end
    assert_equal 10_000, Config.fetch.investment_eur
    assert_equal 4, Config.fetch.precision
  end

  should 'update' do
    @config = Config.fetch
    params = { config: { investment_eur: 10_000, precision: 4 } }
    assert_no_difference 'Config.count' do
      put config_path, params: params
      assert_response :redirect
    end
    assert_equal 10_000, @config.reload.investment_eur
    assert_equal 4, @config.precision
  end
end
