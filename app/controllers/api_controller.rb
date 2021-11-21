class ApiController < ApplicationController
  before_action :create_process, only: %i[list prices]

  def list
    ApiListJob.perform_later(@app_process)
    render json: {id: @app_process.id}
  end

  def prices
    ApiPricesJob.perform_later(@app_process)
    render json: {id: @app_process.id}
  end

  private

  def create_process
    @app_process = AppProcess.create!
  end
end
