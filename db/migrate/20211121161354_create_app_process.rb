# frozen_string_literal: true

class CreateAppProcess < ActiveRecord::Migration[6.1]
  def change
    create_table :app_processes, id: :uuid do |t|
      t.string :status
      t.string :message

      t.timestamps
    end
  end
end
