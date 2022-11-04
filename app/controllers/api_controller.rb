# frozen_string_literal: true

class ApiController < AuthenticatedController
  include Processable

  before_action :create_process, only: %i[list prices]

  def list
    ApiListJob.perform_later(@app_process)
    render json: { id: @app_process.id }
  end

  def prices
    ApiPricesJob.perform_later(@app_process, current_user)
    render json: { id: @app_process.id }
  end
end
