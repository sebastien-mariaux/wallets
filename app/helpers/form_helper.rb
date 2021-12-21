# frozen_string_literal: true

module FormHelper
  def validation_class(object, field)
    if object.errors.messages.key? field
      'is-invalid'
    else
      ''
    end
  end
end
