class ApiController < ApplicationController
  def list
    ApiListJob.perform_later
    head :ok
  end

  def prices
    ApiPricesJob.perform_later
    head :ok
  end
end
