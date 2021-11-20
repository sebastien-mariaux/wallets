require 'api/coin_gecko/coin_list'

class ApiListJob < ApplicationJob
  def perform
    api = Api::CoinGecko::CoinList.new
    api.run
  end
end