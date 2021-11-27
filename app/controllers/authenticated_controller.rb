# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :authenticate_user!

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
