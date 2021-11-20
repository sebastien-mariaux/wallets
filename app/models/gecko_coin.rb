class GeckoCoin < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true
  validates :api_id, presence: true, uniqueness: true

  scope :search, lambda {|query| 
    where("code ILIKE '#{query}%'").order(:code)
  }

  def display_name
    "#{name} (#{code})"
  end
end