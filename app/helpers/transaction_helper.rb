# frozen_string_literal: true

module TransactionHelper
  def order_type_select
    [
      [t('.buy'), 'buy'],
      [t('.sell'), 'sell']
    ]
  end
end
