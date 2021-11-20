require 'api/coin_gecko/coin_value'

class ApiPricesJob < ApplicationJob
  def perform
    api = Api::CoinGecko::CoinValue.new
    api.run
  end
end