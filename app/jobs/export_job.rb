# frozen_string_literal: true

require 'backup/export'

class ExportJob < ApplicationJob
  def perform(process)
    export = Backup::Export.new
    export.run
    process.reload.update!(status: 'done', message: 'Backup effectué',
                           reload_data: false)
  end
end
