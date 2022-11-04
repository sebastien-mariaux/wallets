# frozen_string_literal: true

require 'test_helper'
require 'api/coin_gecko/coin_value'
require 'builders/snapshot_builder'

class SnapshotBuilderTest < ActiveSupport::TestCase
  setup do
    @user = users(:seba)
  end

  should 'update price before creating' do
    Api::CoinGecko::CoinValue.any_instance.expects(:run).once
    Builders::SnapshotBuilder.new(@user).build
  end

  should 'create snapshot' do
    assert_difference 'Snapshot.count', 1 do
      Builders::SnapshotBuilder.new(@user).build
    end
  end

  should 'create coin_snapshots' do
    active_coins_count = 5
    assert_difference 'CoinSnapshot.count', active_coins_count do
      Builders::SnapshotBuilder.new(@user).build
    end
  end
end
