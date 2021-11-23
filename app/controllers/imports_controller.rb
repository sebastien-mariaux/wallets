# frozen_string_literal: true

require 'import_transactions/gate_importer'
require 'import_transactions/binance_importer'

class ImportsController < ApplicationController
  include Processable

  before_action :create_process, only: %i[]

  def new
  end

  def create
    exchange = params['source']
    file =  params['csv_file']
    send "import_from_#{exchange}", file
  end

  private

  def import_from_gate(file)
    importer = ImportTransactions::GateImporter.new(file)
    importer.import
  end

  def import_from_binance(file)
    importer = ImportTransactions::BinanceImporter.new(file)
    importer.import
  end

end
