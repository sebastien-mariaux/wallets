# frozen_string_literal: true

class AddPrecisionToConfig < ActiveRecord::Migration[6.1]
  def change
    add_column :configs, :precision, :integer, default: 6
  end
end
