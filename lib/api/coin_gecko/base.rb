module Api
  module CoinGecko
    class Base
      include HTTParty

      attr_accessor :message

      base_uri "https://api.coingecko.com/api/v3" 


    end
  end
end