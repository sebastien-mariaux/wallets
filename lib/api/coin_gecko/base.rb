module Api
  module CoinGecko
    class Base
      include HTTParty

      base_uri "https://api.coingecko.com/api/v3" 
    end
  end
end