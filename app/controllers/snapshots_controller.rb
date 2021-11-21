class SnapshotsController < ApplicationController
  include Processable

  def request_snap
    SnapshotCreateJob.perform_later(@app_process)
    render json: { id: @app_process.id }
  end
end