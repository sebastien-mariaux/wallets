# frozen_string_literal: true
# # frozen_string_literal: true

# require 'csv'

# module ImportTransactions
#   class GateImporter
#     def initialize(file)
#       @csv_data = CSV.read(file)
#       @headers = @csv_data.shift
#       check_consistent_format
#     end

#     def import
#       ActiveRecord::Base.transaction do
#         @csv_data.each do |row|
#           importer = RowImporter.new(row)
#           importer.import
#         end
#       end
#     end

#     def check_consistent_format
#       expected = %w[id date type market price amount total fees]
#       return if @headers == expected

#       raise 'WARNING: Gate transaction file format have changed.'
#     end

#     class RowImporter
#       SOURCE_NAME = 'gate'
#       def initialize(row)
#         @row = row
#         @operation = row[2]
#       end

#       def import
#         return if skip_row?

#         create_transaction
#       end

#       def create_transaction
#         return if Transaction.find_by(imported_from: SOURCE_NAME, cex_identifier: row_sha)

#         Transaction.create!(imported_from: SOURCE_NAME, cex_identifier: row_sha,
#                             order_type: order_type, coin_id: coin_id, price_usd: price_usd,
#                             date: transaction_date, quantity: transaction_quantity)
#       end

#       def order_type
#         case @operation
#         when 'Buy', 'Acheter'
#           'buy'
#         when 'Sell', 'Vendre'
#           'sell'
#         else
#           raise 'INVALID TRANSACTION TYPE IN CSV FILE'
#         end
#       end

#       def transaction_quantity
#         debugger if @row[5].to_f.blank?
#         @row[5].to_f
#       end

#       def transaction_date
#         @row[1]
#       end

#       def price_usd
#         @row[4].to_f
#       end

#       def coin_id
#         code = @row[3].split('/').first.downcase
#         Coin.find_by(code: code).id
#       end

#       def skip_row?
#         valid = %w[Sell Buy Acheter Vendre].include?(@operation)
#         !valid
#       end

#       def row_sha
#         @row_sha ||= Digest::SHA2.new(256).hexdigest row_string
#       end

#       def row_string
#         @row.join('')
#       end
#     end
#   end
# end
