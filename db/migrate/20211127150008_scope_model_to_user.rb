class ScopeModelToUser < ActiveRecord::Migration[6.1]
  def change
    create_initial_user

    add_reference :coins, :user, type: :uuid, index: true, foreign_key: true
    add_reference :wallets, :user, type: :uuid, index: true, foreign_key: true
    add_reference :snapshots, :user, type: :uuid, index: true, foreign_key: true
    add_reference :transactions, :user, type: :uuid, index: true, foreign_key: true
    add_reference :coin_wallets, :user, type: :uuid, index: true, foreign_key: true
  end

  def create_initial_user
    User.create!(email: 'sebastien.newsletters@gmail.com', password: 'test1234',
    password_confirmation: 'test1234', confirmed_at: DateTime.current)
  end
end
