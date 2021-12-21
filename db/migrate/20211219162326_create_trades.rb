# frozen_string_literal: true

class CreateTrades < ActiveRecord::Migration[6.1]
  def change
    create_table :trades, id: :uuid do |t|
      t.references :buy_coin, references: :coins, foreign_key: { to_table: :coins }, index: true, type: :uuid
      t.references :sell_coin, references: :coins, foreign_key: { to_table: :coins }, index: true, type: :uuid
      t.decimal :buy_quantity
      t.decimal :sell_quantity
      t.date :date
      t.references :wallet, index: true, foreign_key: true, type: :uuid
      t.references :user, index: true, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
