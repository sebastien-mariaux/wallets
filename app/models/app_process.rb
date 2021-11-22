# frozen_string_literal: true

# == Schema Information
#
# Table name: app_processes
#
#  id          :uuid             not null, primary key
#  status      :string
#  message     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  reload_data :boolean          default(FALSE)
#
class AppProcess < ApplicationRecord
  STATUSES = %w[pending done].freeze
  validates :status, inclusion: { in: STATUSES }, allow_nil: true

  before_create :init_status

  private

  def init_status
    self.status = 'pending'
  end
end
