class Coin < ApplicationRecord
  has_many :coin_wallets
  has_many :wallets, through: :coin_wallets
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  belongs_to :gecko_coin, optional: true

  delegate :api_id, to: :gecko_coin


  def display_name
    "#{name} (#{code.upcase})"
  end

  def total_quantity
    coin_wallets.inject(0) do |acc, coin_wallet|
      acc += coin_wallet.quantity
      acc
    end
  end

  %w[usd eur btc].each do |currency|
    define_method "#{currency}_value" do
      coin_wallets.inject(0) do |sum, coin_wallet|
        sum += coin_wallet.send("#{currency}_value")
      end
    end
  end

end