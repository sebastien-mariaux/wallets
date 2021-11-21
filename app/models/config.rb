class Config < ApplicationRecord
  validates :singleton_guard, uniqueness: true, presence: true
  validates_inclusion_of :singleton_guard, :in => [0]

  def self.fetch
    Config.first || Config.create
  end
end