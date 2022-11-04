# frozen_string_literal: true

# == Schema Information
#
# Table name: wallets
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :uuid
#
require 'test_helper'

class CoinTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).scoped_to(:user_id)

  context 'compute totals' do
    setup do
      @ledger = wallets(:ledger)
      @eth_ledger = coin_wallets(:eth_ledger)
      @cvx_ledger = coin_wallets(:cvx_ledger)
    end

    should 'compute usd_value' do
      expected = 5.41 * 4212.51 + 25 * 20.67
      assert_equal expected.round(4), @ledger.currency_value('usd').round(4)
    end

    should 'compute eur_value' do
      expected = 5.41 * 3737.68 + 25 * 18.34
      assert_equal expected.round(4), @ledger.currency_value('eur').round(4)
    end

    should 'compute btc_value' do
      expected = 5.41 * 0.07319436 + 25 * 0.00035915
      assert_equal expected.round(4), @ledger.currency_value('btc').round(4)
    end
  end
end
