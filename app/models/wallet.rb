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
#  user_id     :uuid
#
class Wallet < ApplicationRecord
  belongs_to :user
  has_many :coin_wallets
  has_many :coins, through: :coin_wallets
  validates :name, presence: true, uniqueness: { scope: :user_id }

  # %w[usd eur btc].each do |currency|
  #   define_method "#{currency}_value" do
  #     coin_wallets.inject(0) do |sum, coin_wallet|
  #       sum += coin_wallet.currency_value(currency)
  #     end
  #   end
  # end

  def currency_value(currency)
    coin_wallets.inject(0) do |sum, coin_wallet|
      sum += coin_wallet.currency_value(currency)
    end
  end
end
