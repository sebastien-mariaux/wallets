# frozen_string_literal: true

class AddCurrencySettingsToUser < ActiveRecord::Migration[6.1]
  def change
    add_columns :users, :display_usd, type: :boolean, default: true
    add_columns :users, :display_btc, type: :boolean, default: true
    add_columns :users, :display_main, type: :boolean, default: true
    add_columns :users, :main_currency, type: :string, default: 'eur'
  end
end
