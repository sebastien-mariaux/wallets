class AddInvestmentCurrencyToSnapshot < ActiveRecord::Migration[6.1]
  def change
    add_column :snapshots, :investment_currency, :string
    rename_column :snapshots, :investment_eur, :investment
  end
end
