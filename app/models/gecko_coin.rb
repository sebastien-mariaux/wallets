# frozen_string_literal: true

# == Schema Information
#
# Table name: gecko_coins
#
#  id         :uuid             not null, primary key
#  name       :string
#  code       :string
#  api_id     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class GeckoCoin < ApplicationRecord
  has_many :coins, dependent: :nullify
  validates :name, presence: true
  validates :code, presence: true
  validates :api_id, presence: true, uniqueness: true

  scope :search, lambda { |query|
    where("code ILIKE '#{query}%'").order(:code)
  }

  scope :applied, lambda {
    joins(:coins).where.not(coins: {id: nil})
  }

  def display_name
    "#{name} (#{code})"
  end
end
