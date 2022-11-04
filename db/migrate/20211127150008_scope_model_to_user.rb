# frozen_string_literal: true

class ScopeModelToUser < ActiveRecord::Migration[6.1]
  def change
    # create_initial_user

    add_reference :coins, :user, type: :uuid, index: true, foreign_key: true
    add_reference :wallets, :user, type: :uuid, index: true, foreign_key: true
    add_reference :snapshots, :user, type: :uuid, index: true, foreign_key: true
    add_reference :transactions, :user, type: :uuid, index: true, foreign_key: true
    add_reference :coin_wallets, :user, type: :uuid, index: true, foreign_key: true

    # add_user_to_existing_data
  end

  # def create_initial_user
  #   user = User.new(email: 'sebastien.newsletters@gmail.com', password: 'test1234',
  #   password_confirmation: 'test1234', confirmed_at: DateTime.current)
  #   user.save(validate: false)
  # end

  # def add_user_to_existing_data
  #   [Coin, Wallet, Snapshot, Transaction, CoinWallet].each do |model|
  #     model.update_all(user_id: User.first.id)
  #   end
  # end
end
