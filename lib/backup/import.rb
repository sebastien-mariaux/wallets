# frozen_string_literal: true

require_relative './base'

module Backup
  class Import < Base
    def run
      ordered_models.each do |model|
        import_model(model)
      end
    end

    def import_model(model)
      if model == User
        import_users
      else
        import_other_models(model)
      end
    end

    def import_other_models(model)
      puts "importing #{model}..."
      objects_for(model).each { |object| create_instance(model, object) }
    end

    def import_users
      puts 'importing User...'
      objects_for(User).each do |object|
        object.merge!(password: Devise.friendly_token.first(16))
        create_instance(User, object)
      end
    end

    def create_instance(model, object)
      created = model.new(object)
      return if created.save

      puts "Failed to create #{model} with params #{object}"
    end

    def objects_for(model)
      target_file = file_for(model)
      JSON.parse(File.read(target_file))['data']
    end
  end
end
