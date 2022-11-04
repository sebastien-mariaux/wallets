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
require 'test_helper'

class AppProcessTest < ActiveSupport::TestCase
  should validate_inclusion_of(:status).in_array(%w[pending done])

  should 'init status' do
    new_process = AppProcess.create
    assert_equal 'pending', new_process.status
  end
end
