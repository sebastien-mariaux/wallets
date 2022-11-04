# frozen_string_literal: true

require_relative './user_authenticated_controller_test'

class SnapshotsControllerTest < UserAuthenticatedControllerTest
  should 'get index' do
    get snapshots_path
    assert_response :success
    assert_select 'h1', text: 'Historique'
    assert_not assigns(:snapshots).include? snapshots(:james_one)
  end

  should 'request snapshot' do
    assert_enqueued_jobs 1, only: SnapshotCreateJob do
      get request_snap_snapshots_path
    end
    assert_response :success
    assert_equal ['id'], JSON.parse(response.body).keys
  end
end
