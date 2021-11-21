class Snapshot < ApplicationRecord
  has_many :coin_snapshots, dependent: :destroy
  has_many :coins, through: :coin_snapshots

  accepts_nested_attributes_for :coin_snapshots
end