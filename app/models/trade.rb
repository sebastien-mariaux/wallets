class Trade < ApplicationRecord
  belongs_to :buy_coin, class_name: 'Coin'
  belongs_to :sell_coin, class_name: 'Coin'
  belongs_to :wallet
  belongs_to :user

  validates :buy_quantity, presence: true
  validates :sell_quantity, presence: true
  validates_numericality_of :buy_quantity, greater_than: 0
  validates_numericality_of :sell_quantity, greater_than: 0

  after_save :update_coin_wallets_quantity

  private

  def update_coin_wallets_quantity
    update_sell_coin_wallet_quantity
    update_buy_coin_wallet_quantity
  end

  def update_sell_coin_wallet_quantity
    coin_wallet = user.coin_wallets.find_or_create_by(coin_id: sell_coin_id, wallet_id: wallet_id)
    new_quantity = [(coin_wallet.quantity || 0) - sell_quantity, 0].max
    coin_wallet.update(quantity: new_quantity)
  end

  def update_buy_coin_wallet_quantity
    coin_wallet = user.coin_wallets.find_or_create_by(coin_id: buy_coin_id, wallet_id: wallet_id)
    new_quantity = (coin_wallet.quantity || 0) + buy_quantity
    coin_wallet.update(quantity: new_quantity)
  end
end
