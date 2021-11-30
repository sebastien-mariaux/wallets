# frozen_string_literal: true
# # frozen_string_literal: true

# require 'csv'

# module ImportTransactions
#   class BinanceImporter
#     def initialize(file)
#       @csv_data = CSV.read(file)
#       @headers = @csv_data.shift
#       check_consistent_format
#     end

#     def import
#       @csv_data.each do |row|
#         importer = RowImporter.new(row)
#         importer.import
#       end
#     end

#     def import_row(row); end

#     def check_consistent_format
#       expected = %w[UTC_Time Account Operation Coin Change Remark]
#       return if @headers == expected

#       raise 'WARNING: Binance transaction file format have changed.'
#     end

#     class RowImporter
#       SOURCE_NAME = 'binance'
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
#                             order_type: order_type, coin_id: coin_id)
#       end

#       def order_type
#         @operation.downcase
#       end

#       def coin_id
#         @row[]
#       end

#       def skip_row?
#         valid = %w[Sell Buy].include?(@operation)
#         !valid
#       end

#       def row_sha
#         @row_sha ||= Digest::SHA2.new(256).hexdigest row_string
#       end

#       def row_string
#         row.join('')
#       end
#     end
#   end
# end
