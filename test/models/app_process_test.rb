require 'test_helper'

class AppProcessTest < ActiveSupport::TestCase
  should validate_inclusion_of(:status).in_array(%w[pending done])

  should 'init status' do
    new_process = AppProcess.create
    assert_equal 'pending', new_process.status
  end
end