# frozen_string_literal: true

# == Schema Information
#
# Table name: wallets
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
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
