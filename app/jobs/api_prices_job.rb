# frozen_string_literal: true

require 'api/coin_gecko/coin_value'

class ApiPricesJob < ApplicationJob
  def perform(process)
    api = Api::CoinGecko::CoinValue.new
    api.run
    process.reload.update!(status: 'done', message: api.message, reload_data: true)
  end
end
