# frozen_string_literal: true

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
#  display_main           :boolean          default(TRUE)
#  main_currency          :string           default("eur")
#  display_secondary      :boolean
#  display_tertiary       :boolean
#  secondary_currency     :text
#  tertiary_currency      :text
#  investment_currency    :text
#
class User < ApplicationRecord
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
  has_many :trades, dependent: :destroy

  validates :main_currency, inclusion: { in: SUPPORTED_CURRENCIES }
  validates :secondary_currency, inclusion: { in: SUPPORTED_CURRENCIES, allow_nil: true }
  validates :tertiary_currency, inclusion: { in: SUPPORTED_CURRENCIES, allow_nil: true }
  validate :check_investment_currency

  before_create :set_default_values

  def wealth
    @wealth ||= UserWealth.new(self)
  end

  private

  def check_investment_currency
    return if [main_currency, secondary_currency, tertiary_currency].include? investment_currency

    errors.add(:investment_currency, :unknown_currency)
  end

  def set_default_values
    self.main_currency = 'eur'
    self.secondary_currency = 'usd'
    self.tertiary_currency = 'btc'
    self.investment_currency = 'eur'
  end
end
