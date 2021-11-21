# frozen_string_literal: true

class CreateGeckoCoin < ActiveRecord::Migration[6.1]
  def change
    create_table :gecko_coins, id: :uuid do |t|
      t.string :name
      t.string :code
      t.string :api_id

      t.timestamps
    end
  end
end
