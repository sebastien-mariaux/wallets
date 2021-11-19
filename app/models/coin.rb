class Coin < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :code, presence: true, uniqueness: true

    def display_name
        "#{name} (#{code})"
    end
end