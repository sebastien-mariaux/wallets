# frozen_string_literal: true

class CreateTransaction < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :order_type
      t.references :coin, index: true, type: :uuid, foreign_key: true
      t.decimal :quantity
      t.decimal :price_usd
      t.date :date

      t.timestamps
    end
  end
end
