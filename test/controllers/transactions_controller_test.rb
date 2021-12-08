# frozen_string_literal: true
require_relative './user_authenticated_controller_test'

class TransactionsControllerTest < UserAuthenticatedControllerTest
  setup do
    @coin = coins(:xrp)
  end

  should 'get index' do
    get coin_transactions_path(@coin)
    assert_response :success
  end
end