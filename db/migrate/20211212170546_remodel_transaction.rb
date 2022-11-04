# frozen_string_literal: true

class RemodelTransaction < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :price_usd
    add_column :transactions, :price_reference_currency, :decimal
    add_column :transactions, :reference_currency, :string
    Transaction.destroy_all
  end
end
