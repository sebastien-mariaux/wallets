# frozen_string_literal: true

class ChangeCoin < ActiveRecord::Migration[6.1]
  def change
    remove_column :coins, :api_id
    add_reference :coins, :gecko_coin, type: :uuid, index: true
  end
end
