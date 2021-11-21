# frozen_string_literal: true

class ConfigController < ApplicationController
  before_action :load_config

  def show; end

  def edit; end

  def update
    if @config.update(update_params)
      redirect_to config_path
    else
      render status: :unprocessable_entity
    end
  end

  private

  def update_params
    params.require(:config).permit(:investment_eur)
  end

  def load_config
    @config = Config.fetch
  end
end
