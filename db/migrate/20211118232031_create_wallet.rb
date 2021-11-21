# frozen_string_literal: true

class CreateWallet < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets, id: :uuid do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
