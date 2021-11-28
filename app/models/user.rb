# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  precision              :integer          default(6)
#  investment             :decimal(, )      default(0.0)
#  display_secondary            :boolean
#  display_tertiary            :boolean
#  display_main          :boolean
#  local_currency         :string           default("eur")
#  main_currency          :string           default("eur")
#
class User < ApplicationRecord
  # https://api.coingecko.com/api/v3/simple/supported_vs_currencies
  SUPPORTED_CURRENCIES = %w[btc eth ltc bch bnb eos xrp xlm lin dot yfi usd aed ars sat
                            aud bdt bhd bmd brl cad chf clp cny czk dkk eur gbp hkd huf idr 
                            ils inr jpy krw kwd lkr mmk mxn myr ngn nok nzd php pkr pln rub 
                            sar sek sgd thb try twd uah vef vnd zar xdr xag xau bit].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  has_many :coins, dependent: :destroy
  has_many :wallets, dependent: :destroy
  has_many :coin_wallets, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :snapshots, dependent: :destroy

  validates :main_currency, inclusion: { in: SUPPORTED_CURRENCIES }

  def wealth
    @wealth ||= UserWealth.new(self)
  end
end
