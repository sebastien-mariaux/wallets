# frozen_string_literal: true

class AddReferencePriceToCoin < ActiveRecord::Migration[6.1]
  def change
    add_columns :coins, :reference_price, type: :decimal
  end
end
