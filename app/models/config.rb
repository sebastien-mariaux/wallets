# frozen_string_literal: true

# == Schema Information
#
# Table name: configs
#
#  id              :bigint           not null, primary key
#  singleton_guard :integer          default(0)
#  investment_eur  :decimal(, )      default(0.0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  precision       :integer          default(6)
#
class Config < ApplicationRecord
  validates :singleton_guard, uniqueness: true, presence: true
  validates_inclusion_of :singleton_guard, in: [0]

  def self.fetch
    Config.first || Config.create
  end
end
