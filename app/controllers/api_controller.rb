# frozen_string_literal: true

class ApiController < ApplicationController
  include Processable

  def list
    ApiListJob.perform_later(@app_process)
    render json: { id: @app_process.id }
  end

  def prices
    ApiPricesJob.perform_later(@app_process)
    render json: { id: @app_process.id }
  end
end
