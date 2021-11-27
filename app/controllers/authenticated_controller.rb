# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :authenticate_user!

  def debug(text)
    File.open('debug.log', 'a') do |f|
      f.puts text
    end
  end
end
