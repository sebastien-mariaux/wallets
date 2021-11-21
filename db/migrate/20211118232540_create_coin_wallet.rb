# frozen_string_literal: true

class CreateCoinWallet < ActiveRecord::Migration[6.1]
  def change
    create_table :coin_wallets, id: :uuid do |t|
      t.references :coin, index: true, foreign_key: true, type: :uuid
      t.references :wallet, index: true, foreign_key: true, type: :uuid
      t.decimal :quantity

      t.timestamps
    end
  end
end
