# frozen_string_literal: true

require 'json'

module Backup
  class Base
    BASE_DIR = Rails.root.join('db', 'dump')

    def ordered_models
      [Config, GeckoCoin, Coin, Wallet, CoinWallet, AppProcess, 
       Snapshot, CoinSnapshot]
    end

    def file_for(model)
      filename = "#{model.to_s.underscore}_data.json"
      File.join(BASE_DIR, filename)
    end
  end
end
