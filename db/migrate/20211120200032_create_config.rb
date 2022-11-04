# frozen_string_literal: true

class CreateConfig < ActiveRecord::Migration[6.1]
  def change
    create_table :configs, id: :uuid do |t|
      t.integer  :singleton_guard, default: 0
      t.decimal :investment, default: 0

      t.timestamps
    end
  end
end
