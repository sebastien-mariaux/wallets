# frozen_string_literal: true

class AddInvestmentCurrencyToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :investment_currency, :text
  end
end
