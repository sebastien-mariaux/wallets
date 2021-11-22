# frozen_string_literal: true

class SnapshotsController < ApplicationController
  include Processable

  before_action :load_snapshots, only: :index

  def request_snap
    SnapshotCreateJob.perform_later(@app_process)
    render json: { id: @app_process.id }
  end

  def index

  end

  private

  def load_snapshots
    @snapshots = Snapshot.order(:created_at)
  end
end