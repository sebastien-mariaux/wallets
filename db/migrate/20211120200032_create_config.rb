class CreateConfig < ActiveRecord::Migration[6.1]
  def change
    create_table :configs do |t|
      t.integer  :singleton_guard, default: 0
      t.decimal :investment_eur, default: 0

      t.timestamps
    end
  end
end
