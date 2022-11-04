# # frozen_string_literal: true

# class TransactionsController < AuthenticatedController
#   before_action :load_coin
#   before_action :load_transactions, only: %i[index destroy]
#   before_action :load_transaction, only: :destroy

#   layout false, only: :create

#   def index; end

#   def new; end

#   def destroy
#     @transaction.destroy
#     redirect_to coin_transactions_path(@coin)
#   end

#   def create
#     @transaction = @coin.transactions.new(allowed_params)
#     if @transaction.save
#       render :transaction_row
#     else
#       render :inline_form, status: :unprocessable_entity
#     end
#   end

#   private

#   def allowed_params
#     params.require(:transaction)
#           .permit(:date, :order_type, :quantity, :price_reference_currency,
#                   :reference_currency, :cex_identifier)
#   end

#   def load_coin
#     @coin = current_user.coins.find(params[:coin_id])
#   end

#   def load_transactions
#     @transactions = @coin.transactions
#   end

#   def load_transaction
#     @transaction = @transactions.find(params[:id])
#   end
# end
