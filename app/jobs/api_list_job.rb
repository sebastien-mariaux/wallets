# frozen_string_literal: true

require 'api/coin_gecko/coin_list'

class ApiListJob < ApplicationJob
  def perform(process)
    api = Api::CoinGecko::CoinList.new
    api.run
    process.reload.update!(status: 'done', message: api.message, reload_data: true)
  end
end
