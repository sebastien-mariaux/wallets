# # frozen_string_literal: true

# require_relative './user_authenticated_controller_test'

# class TransactionsControllerTest < UserAuthenticatedControllerTest
#   setup do
#     @coin = coins(:xrp)
#   end

#   should 'get index' do
#     get coin_transactions_path(@coin)
#     assert_response :success
#   end

#   should 'get new' do
#     get new_coin_transaction_path(@coin)
#     assert_response :success
#   end

#   should 'create' do
#     params = { transaction: {
#       date: Date.current, order_type: 'buy', quantity: 100,
#       price_reference_currency: 0.9,
#       reference_currency: 'usd', cex_identifier: 'test gate'
#     } }
#     assert_difference 'Transaction.count', 1 do
#       post coin_transactions_path(@coin), params: params
#       assert_response :redirect
#     end
#     assert_equal Transaction.find_by(cex_identifier: 'test gate').user, @logged_user
#   end
# end
