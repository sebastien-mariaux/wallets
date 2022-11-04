# frozen_string_literal: true

require_relative './user_authenticated_controller_test'

class ApiControllerTest < UserAuthenticatedControllerTest
  context 'coin list' do
    should 'return process id' do
      get list_api_index_path
      assert_response :success
      process = assigns(:app_process)
      assert_equal process.id, JSON.parse(response.body)['id']
    end

    should 'enqueued api job' do
      assert_enqueued_jobs 1, only: ApiListJob do
        get list_api_index_path
      end
    end
  end

  context 'coin prices' do
    should 'return process id' do
      get prices_api_index_path
      assert_response :success
      process = assigns(:app_process)
      assert_equal process.id, JSON.parse(response.body)['id']
    end

    should 'enqueued api job' do
      assert_enqueued_jobs 1, only: ApiPricesJob do
        get prices_api_index_path
      end
    end
  end
end
