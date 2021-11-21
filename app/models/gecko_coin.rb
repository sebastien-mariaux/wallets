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
  validates :name, presence: true
  validates :code, presence: true
  validates :api_id, presence: true, uniqueness: true

  scope :search, lambda { |query|
    where("code ILIKE '#{query}%'").order(:code)
  }

  def display_name
    "#{name} (#{code})"
  end
end
