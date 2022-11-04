# frozen_string_literal: true

class SnapshotsController < AuthenticatedController
  include Processable
  before_action :load_snapshots, only: :index
  before_action :create_process, only: :request_snap

  def request_snap
    SnapshotCreateJob.perform_later(current_user, @app_process)
    render json: { id: @app_process.id }
  end

  def index
    @user_currencies = current_user.snapshots.user_currencies(current_user)
  end

  private

  def load_snapshots
    @snapshots = current_user.snapshots.order(:created_at)
  end
end
