# frozen_string_literal: true

class BackupsController < AuthenticatedController
  include Processable

  before_action :create_process, only: %i[import export]

  def import
    ImportJob.perform_later(@app_process)
    render json: { id: @app_process.id }
  end

  def export
    ExportJob.perform_later(@app_process)
    render json: { id: @app_process.id }
  end
end
