module TransactionHelper
  def order_type_select
    [
      [t('.buy'), 'buy'],
      [t('.sell'), 'sell']
    ]
  end
end