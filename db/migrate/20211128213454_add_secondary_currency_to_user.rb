# frozen_string_literal: true

class AddSecondaryCurrencyToUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :display_usd, :boolean
    remove_column :users, :display_btc, :boolean
    add_column :users, :display_secondary, :boolean
    add_column :users, :display_tertiary, :boolean
    add_column :users, :secondary_currency, :text
    add_column :users, :tertiary_currency, :text
  end
end
