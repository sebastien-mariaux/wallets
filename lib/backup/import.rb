require_relative './base'

module Backup
  class Import < Base
    def run
      ordered_models.each do |model| 
        import_model(model)
      end
    end

    def import_model(model)
      target_file = file_for(model)
      objects = JSON.parse(File.read(target_file))['data']
      model.create(objects)
    end
  end
end
