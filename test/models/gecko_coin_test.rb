# frozen_string_literal: true

# == Schema Information
#
# Table name: gecko_coins
#
#  id               :uuid             not null, primary key
#  name             :string
#  code             :string
#  api_id           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  market_value_btc :decimal(, )
#  market_value_eur :decimal(, )
#  market_value_usd :decimal(, )
#  market_value_eth :decimal(, )
#  market_value_ltc :decimal(, )
#  market_value_bch :decimal(, )
#  market_value_bnb :decimal(, )
#  market_value_eos :decimal(, )
#  market_value_xrp :decimal(, )
#  market_value_xlm :decimal(, )
#  market_value_lin :decimal(, )
#  market_value_dot :decimal(, )
#  market_value_yfi :decimal(, )
#  market_value_aed :decimal(, )
#  market_value_ars :decimal(, )
#  market_value_sat :decimal(, )
#  market_value_aud :decimal(, )
#  market_value_bdt :decimal(, )
#  market_value_bhd :decimal(, )
#  market_value_bmd :decimal(, )
#  market_value_brl :decimal(, )
#  market_value_cad :decimal(, )
#  market_value_chf :decimal(, )
#  market_value_clp :decimal(, )
#  market_value_cny :decimal(, )
#  market_value_czk :decimal(, )
#  market_value_dkk :decimal(, )
#  market_value_gbp :decimal(, )
#  market_value_hkd :decimal(, )
#  market_value_huf :decimal(, )
#  market_value_idr :decimal(, )
#  market_value_ils :decimal(, )
#  market_value_inr :decimal(, )
#  market_value_jpy :decimal(, )
#  market_value_krw :decimal(, )
#  market_value_kwd :decimal(, )
#  market_value_lkr :decimal(, )
#  market_value_mmk :decimal(, )
#  market_value_mxn :decimal(, )
#  market_value_myr :decimal(, )
#  market_value_ngn :decimal(, )
#  market_value_nok :decimal(, )
#  market_value_nzd :decimal(, )
#  market_value_php :decimal(, )
#  market_value_pkr :decimal(, )
#  market_value_pln :decimal(, )
#  market_value_rub :decimal(, )
#  market_value_sar :decimal(, )
#  market_value_sek :decimal(, )
#  market_value_sgd :decimal(, )
#  market_value_thb :decimal(, )
#  market_value_try :decimal(, )
#  market_value_twd :decimal(, )
#  market_value_uah :decimal(, )
#  market_value_vef :decimal(, )
#  market_value_vnd :decimal(, )
#  market_value_zar :decimal(, )
#  market_value_xdr :decimal(, )
#  market_value_xag :decimal(, )
#  market_value_xau :decimal(, )
#  market_value_bit :decimal(, )
#
require 'test_helper'

class GeckoCoinTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should validate_presence_of :code
  should validate_presence_of :api_id
  should validate_uniqueness_of(:api_id)

  context 'search' do
    should 'fail search by name' do
      assert_equal 0, GeckoCoin.search('Cardano').count
    end

    should 'succeed by code' do
      assert_equal 1, GeckoCoin.search('ADA').count
    end

    should 'succeed by partial code' do
      assert_equal 2, GeckoCoin.search('b').count
    end
  end

  should 'get applied gecko coins' do
    applied = GeckoCoin.applied
    assert gecko_coins(:ada).coins.empty?
    assert_not applied.include? gecko_coins(:ada)
    assert gecko_coins(:eth).coins.present?
    assert applied.include? gecko_coins(:eth)
  end
end
