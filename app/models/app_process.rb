class AppProcess < ApplicationRecord
  STATUSES = ['pending', 'done']
  validates :status, inclusion: {in: STATUSES}, allow_nil: true

  before_create :init_status

  private

  def init_status
    self.status = 'pending'
  end
end