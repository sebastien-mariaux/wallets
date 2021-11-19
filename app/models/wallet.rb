class Wallet < ApplicationRecord
    validates :name, presence: true, uniqueness: true
end