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

ActiveRecord::Schema.define(version: 2021_11_29_235334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "app_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "status"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "reload_data", default: false
  end

  create_table "coin_snapshots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "coin_id"
    t.uuid "snapshot_id"
    t.decimal "quantity"
    t.decimal "price_currency_1"
    t.decimal "price_currency_2"
    t.decimal "price_currency_3"
    t.index ["coin_id"], name: "index_coin_snapshots_on_coin_id"
    t.index ["snapshot_id"], name: "index_coin_snapshots_on_snapshot_id"
  end

  create_table "coin_wallets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "coin_id"
    t.uuid "wallet_id"
    t.decimal "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "user_id"
    t.index ["coin_id"], name: "index_coin_wallets_on_coin_id"
    t.index ["user_id"], name: "index_coin_wallets_on_user_id"
    t.index ["wallet_id"], name: "index_coin_wallets_on_wallet_id"
  end

  create_table "coins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "gecko_coin_id"
    t.decimal "reference_price"
    t.boolean "hide", default: false
    t.uuid "user_id"
    t.index ["gecko_coin_id"], name: "index_coins_on_gecko_coin_id"
    t.index ["user_id"], name: "index_coins_on_user_id"
  end

  create_table "gecko_coins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "api_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "market_value_btc"
    t.decimal "market_value_eur"
    t.decimal "market_value_usd"
    t.decimal "market_value_eth"
    t.decimal "market_value_ltc"
    t.decimal "market_value_bch"
    t.decimal "market_value_bnb"
    t.decimal "market_value_eos"
    t.decimal "market_value_xrp"
    t.decimal "market_value_xlm"
    t.decimal "market_value_lin"
    t.decimal "market_value_dot"
    t.decimal "market_value_yfi"
    t.decimal "market_value_aed"
    t.decimal "market_value_ars"
    t.decimal "market_value_sat"
    t.decimal "market_value_aud"
    t.decimal "market_value_bdt"
    t.decimal "market_value_bhd"
    t.decimal "market_value_bmd"
    t.decimal "market_value_brl"
    t.decimal "market_value_cad"
    t.decimal "market_value_chf"
    t.decimal "market_value_clp"
    t.decimal "market_value_cny"
    t.decimal "market_value_czk"
    t.decimal "market_value_dkk"
    t.decimal "market_value_gbp"
    t.decimal "market_value_hkd"
    t.decimal "market_value_huf"
    t.decimal "market_value_idr"
    t.decimal "market_value_ils"
    t.decimal "market_value_inr"
    t.decimal "market_value_jpy"
    t.decimal "market_value_krw"
    t.decimal "market_value_kwd"
    t.decimal "market_value_lkr"
    t.decimal "market_value_mmk"
    t.decimal "market_value_mxn"
    t.decimal "market_value_myr"
    t.decimal "market_value_ngn"
    t.decimal "market_value_nok"
    t.decimal "market_value_nzd"
    t.decimal "market_value_php"
    t.decimal "market_value_pkr"
    t.decimal "market_value_pln"
    t.decimal "market_value_rub"
    t.decimal "market_value_sar"
    t.decimal "market_value_sek"
    t.decimal "market_value_sgd"
    t.decimal "market_value_thb"
    t.decimal "market_value_try"
    t.decimal "market_value_twd"
    t.decimal "market_value_uah"
    t.decimal "market_value_vef"
    t.decimal "market_value_vnd"
    t.decimal "market_value_zar"
    t.decimal "market_value_xdr"
    t.decimal "market_value_xag"
    t.decimal "market_value_xau"
    t.decimal "market_value_bit"
  end

  create_table "snapshots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "investment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "user_id"
    t.string "currency_1"
    t.string "currency_2"
    t.string "currency_3"
    t.decimal "total_value_currency_1"
    t.decimal "total_value_currency_2"
    t.decimal "total_value_currency_3"
    t.string "investment_currency"
    t.index ["user_id"], name: "index_snapshots_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "order_type"
    t.uuid "coin_id"
    t.decimal "quantity"
    t.decimal "price_usd"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "imported_from"
    t.string "cex_identifier"
    t.uuid "user_id"
    t.index ["coin_id"], name: "index_transactions_on_coin_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "precision", default: 6
    t.decimal "investment", default: "0.0"
    t.boolean "display_main", default: true
    t.string "main_currency", default: "eur"
    t.boolean "display_secondary"
    t.boolean "display_tertiary"
    t.text "secondary_currency"
    t.text "tertiary_currency"
    t.text "investment_currency"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "user_id"
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "coin_snapshots", "coins"
  add_foreign_key "coin_snapshots", "snapshots"
  add_foreign_key "coin_wallets", "coins"
  add_foreign_key "coin_wallets", "users"
  add_foreign_key "coin_wallets", "wallets"
  add_foreign_key "coins", "users"
  add_foreign_key "snapshots", "users"
  add_foreign_key "transactions", "coins"
  add_foreign_key "transactions", "users"
  add_foreign_key "wallets", "users"
end
