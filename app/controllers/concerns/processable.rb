# frozen_string_literal: true

require 'active_support/concern'

module Processable
  extend ActiveSupport::Concern

  included do
    before_action :create_process
  end

  private

  def create_process
    @app_process = AppProcess.create!
  end
end
