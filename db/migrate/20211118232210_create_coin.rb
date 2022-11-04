# frozen_string_literal: true

class CreateCoin < ActiveRecord::Migration[6.1]
  def change
    create_table :coins, id: :uuid do |t|
      t.string :name
      t.string :code
      t.string :api_id
      t.decimal :market_value_usd
      t.decimal :market_value_eur
      t.decimal :market_value_btc

      t.timestamps
    end
  end
end
