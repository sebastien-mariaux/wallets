# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_22_021931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "app_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "status"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coin_snapshots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "coin_id"
    t.uuid "snapshot_id"
    t.decimal "quantity"
    t.decimal "usd_price"
    t.decimal "eur_price"
    t.index ["coin_id"], name: "index_coin_snapshots_on_coin_id"
    t.index ["snapshot_id"], name: "index_coin_snapshots_on_snapshot_id"
  end

  create_table "coin_wallets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "coin_id"
    t.uuid "wallet_id"
    t.decimal "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_coin_wallets_on_coin_id"
    t.index ["wallet_id"], name: "index_coin_wallets_on_wallet_id"
  end

  create_table "coins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.decimal "market_value_usd"
    t.decimal "market_value_eur"
    t.decimal "market_value_btc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "gecko_coin_id"
    t.index ["gecko_coin_id"], name: "index_coins_on_gecko_coin_id"
  end

  create_table "configs", force: :cascade do |t|
    t.integer "singleton_guard", default: 0
    t.decimal "investment_eur", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "gecko_coins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "api_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "snapshots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "total_usd_value"
    t.decimal "total_eur_value"
    t.decimal "total_btc_value"
    t.decimal "investment_eur"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "order_type"
    t.uuid "coin_id"
    t.decimal "quantity"
    t.decimal "price_usd"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_transactions_on_coin_id"
  end

  create_table "wallets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "coin_snapshots", "coins"
  add_foreign_key "coin_snapshots", "snapshots"
  add_foreign_key "coin_wallets", "coins"
  add_foreign_key "coin_wallets", "wallets"
  add_foreign_key "transactions", "coins"
end
