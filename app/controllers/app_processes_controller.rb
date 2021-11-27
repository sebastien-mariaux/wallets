# frozen_string_literal: true

class AppProcessesController < AuthenticatedController
  before_action :load_app_process, only: :show

  def show
    render json: @app_process.as_json
  end

  private

  def load_app_process
    @app_process = AppProcess.find(params[:id])
  end
end
