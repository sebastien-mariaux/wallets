# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  before_action :load_currencies

  def debug(text)
    File.open('debug.log', 'a') do |f|
      f.puts text
    end
  end

  def load_currencies
    @main_currency = current_user.main_currency
    @secondary_currency = current_user.secondary_currency
    @tertiary_currency = current_user.tertiary_currency
    @investment_currency = current_user.investment_currency
  end
end
