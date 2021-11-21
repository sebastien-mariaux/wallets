require_relative './base'

module Backup
  class Export < Base
    def run
      ordered_models.each do |model| 
        export_model(model)
      end
    end

    def export_model(model)
      target_file = file_for(model)
      data = model.all.inject([]) do |array, instance|
        array << instance.as_json
        array
      end
      File.open(target_file, "w") do |file|
        file.write(JSON.pretty_generate({data: data}))
      end
    end
  end
end
