# frozen_string_literal: true

class AddInvestmentCurrencyToSnapshot < ActiveRecord::Migration[6.1]
  def change
    add_column :snapshots, :investment_currency, :string
  end
end
