class Coin < ApplicationRecord
    has_many :coin_wallets
    has_many :wallets, through: :coin_wallets
    validates :name, presence: true, uniqueness: true
    validates :code, presence: true, uniqueness: true

    def display_name
        "#{name} (#{code})"
    end

    def total_quantity
        coin_wallets.inject(0) do |acc, coin_wallet|
            acc += coin_wallet.quantity
            acc
        end
    end
end