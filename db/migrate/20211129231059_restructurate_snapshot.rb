# frozen_string_literal: true

class RestructurateSnapshot < ActiveRecord::Migration[6.1]
  def change
    add_column :snapshots, :currency_1, :string
    add_column :snapshots, :currency_2, :string
    add_column :snapshots, :currency_3, :string
    add_column :snapshots, :total_value_currency_1, :decimal
    add_column :snapshots, :total_value_currency_2, :decimal
    add_column :snapshots, :total_value_currency_3, :decimal

    migrate_snapshot_data

    remove_column :snapshots, :total_btc_value, :decimal
    remove_column :snapshots, :total_eur_value, :decimal
    remove_column :snapshots, :total_usd_value, :decimal

    add_column :coin_snapshots, :price_currency_1, :decimal
    add_column :coin_snapshots, :price_currency_2, :decimal
    add_column :coin_snapshots, :price_currency_3, :decimal

    migrate_coin_snapshot_data

    remove_column :coin_snapshots, :usd_price, :decimal
    remove_column :coin_snapshots, :eur_price, :decimal
  end

  def migrate_snapshot_data
    Snapshot.find_each do |snapshot|
      snapshot.update!(currency_1: 'eur', currency_2: 'usd', currency_3: 'btc',
                       total_value_currency_1: snapshot.total_eur_value,
                       total_value_currency_2: snapshot.total_usd_value,
                       total_value_currency_2: snapshot.total_btc_value)
    end
  end

  def migrate_coin_snapshot_data
    CoinSnapshot.find_each do |coin_snap|
      coin_snap.update!(price_currency_1: coin_snap.eur_price,
                        price_currency_2: coin_snap.usd_price)
    end
  end
end
