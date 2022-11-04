# frozen_string_literal: true

class MoveConfigToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :precision, :integer, default: 6
    add_column :users, :investment, :decimal, default: 0

    drop_table :configs
  end
end
