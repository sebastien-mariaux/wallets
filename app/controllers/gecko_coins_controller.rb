class GeckoCoinsController < ApplicationController
  layout false, only: :search

  def search
    @results = GeckoCoin.search(params['query'])
  end
end