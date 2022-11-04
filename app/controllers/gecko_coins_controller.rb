# frozen_string_literal: true

class GeckoCoinsController < AuthenticatedController
  layout false, only: :search

  def search
    @results = GeckoCoin.search(params['query'])
  end
end
