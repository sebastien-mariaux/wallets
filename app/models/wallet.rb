class Wallet < ApplicationRecord
  has_many :coin_wallets
  has_many :coins, through: :coin_wallets
  validates :name, presence: true, uniqueness: true

  %w[usd eur btc].each do |currency|
    define_method "#{currency}_value" do
      coin_wallets.inject(0) do |sum, coin_wallet|
        sum += coin_wallet.send("#{currency}_value")
      end
    end
  end
end