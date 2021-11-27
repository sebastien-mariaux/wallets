# frozen_string_literal: true

class AddReloadToAppProcess < ActiveRecord::Migration[6.1]
  def change
    add_column :app_processes, :reload_data, :boolean, default: false
  end
end
