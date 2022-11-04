# frozen_string_literal: true

module ProfileHelper
  def display_currencies
    User::SUPPORTED_CURRENCIES.map do |currency|
      [currency.upcase, currency]
    end
  end
end
