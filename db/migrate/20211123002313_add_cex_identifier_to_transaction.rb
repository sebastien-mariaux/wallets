# frozen_string_literal: true

class AddCexIdentifierToTransaction < ActiveRecord::Migration[6.1]
  def change
    add_columns :transactions, :imported_from, type: :string
    add_columns :transactions, :cex_identifier, type: :string
  end
end
