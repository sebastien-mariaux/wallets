# frozen_string_literal: true

require 'backup/import'

class ImportJob < ApplicationJob
  def perform(process)
    import = Backup::Import.new
    import.run
    process.reload.update!(status: 'done', message: 'Importation effectuée',
                           reload_data: true)
  end
end
