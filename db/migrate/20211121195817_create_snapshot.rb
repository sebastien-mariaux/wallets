# frozen_string_literal: true

class CreateSnapshot < ActiveRecord::Migration[6.1]
  def change
    create_table :snapshots, id: :uuid do |t|
      t.decimal :total_usd_value
      t.decimal :total_eur_value
      t.decimal :total_btc_value
      t.decimal :investment

      t.timestamps
    end

    create_table :coin_snapshots, id: :uuid do |t|
      t.references :coin, index: true, foreign_key: true, type: :uuid
      t.references :snapshot, index: true, foreign_key: true, type: :uuid
      t.decimal :quantity
      t.decimal :usd_price
      t.decimal :eur_price
    end
  end
end
