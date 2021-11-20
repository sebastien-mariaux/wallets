class ApiController < ApplicationController
  def list
    ApiListJob.perform_later
    head :ok
  end
end
