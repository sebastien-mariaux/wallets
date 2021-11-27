# frozen_string_literal: true

class AddHideToCoin < ActiveRecord::Migration[6.1]
  def change
    add_column :coins, :hide, :boolean, default: false
  end
end
