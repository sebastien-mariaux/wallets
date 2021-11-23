# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :load_config

  def debug(text)
    File.open('debug.log', 'a') do |f|
      f.puts text
    end
  end

  def load_config
    @config = Config.fetch
  end
end
