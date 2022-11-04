# frozen_string_literal: true

require 'backup/export'
require 'backup/import'

namespace :backup do
  desc 'Populate database with json data'
  task import: :environment do
    import = Backup::Import.new
    import.run
  end

  desc 'Export data to json files'
  task export: :environment do
    export = Backup::Export.new
    export.run
  end
end
