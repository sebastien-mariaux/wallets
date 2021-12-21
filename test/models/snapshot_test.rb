# frozen_string_literal: true

# == Schema Information
#
# Table name: snapshots
#
#  id                     :uuid             not null, primary key
#  investment             :decimal(, )
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :uuid
#  currency_1             :string
#  currency_2             :string
#  currency_3             :string
#  total_value_currency_1 :decimal(, )
#  total_value_currency_2 :decimal(, )
#  total_value_currency_3 :decimal(, )
#  investment_currency    :string
#
require 'test_helper'

class SnapshotTest < ActiveSupport::TestCase
  setup do
    @snapshot = snapshots(:one)
  end

  should 'be valued in eur' do
    assert @snapshot.valued_in?('eur')
  end

  should 'not be valued in cad' do
    assert_not @snapshot.valued_in?('cad')
  end

  should 'scope for currency' do
    assert_equal [snapshots(:james_one)], Snapshot.for_currency('cad')
  end

  should 'get value for currency' do
    assert_equal 0.15129, @snapshot.total_value('btc')
  end

  should 'get nil for invalid currency' do
    assert_nil @snapshot.total_value('cad')
  end

  should 'get all user currencies' do
    assert_equal %w[btc cad eur usd], Snapshot.user_currencies(users(:james)).sort
    assert_equal %w[btc eur usd], Snapshot.user_currencies(users(:seba)).sort
  end
end
