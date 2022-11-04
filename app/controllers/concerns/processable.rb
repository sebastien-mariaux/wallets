# frozen_string_literal: true

require 'active_support/concern'

module Processable
  extend ActiveSupport::Concern

  private

  def create_process
    @app_process = AppProcess.create!
  end
end
