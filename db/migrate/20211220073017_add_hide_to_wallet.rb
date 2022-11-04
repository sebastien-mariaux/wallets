class AddHideToWallet < ActiveRecord::Migration[6.1]
  def change
    add_column :wallets, :hide, :boolean, default: false
  end
end
