# frozen_string_literal: true

class MovePricesToGeckoCoin < ActiveRecord::Migration[6.1]
  def change
    remove_column :coins, :market_value_btc, :decimal
    remove_column :coins, :market_value_eur, :decimal
    remove_column :coins, :market_value_usd, :decimal

    add_column :gecko_coins, :market_value_btc, :decimal
    add_column :gecko_coins, :market_value_eur, :decimal
    add_column :gecko_coins, :market_value_usd, :decimal
  end
end
