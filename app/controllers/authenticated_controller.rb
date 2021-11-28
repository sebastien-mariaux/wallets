# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  before_action :load_main_currency

  def debug(text)
    File.open('debug.log', 'a') do |f|
      f.puts text
    end
  end

  def load_main_currency
    @main_currency = current_user.main_currency
  end
end
