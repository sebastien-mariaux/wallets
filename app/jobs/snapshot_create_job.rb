# frozen_string_literal: true

require 'builders/snapshot_builder'

class SnapshotCreateJob < ApplicationJob
  def perform(process)
    builder = Builders::SnapshotBuilder.new
    builder.build
    process.reload.update!(status: 'done', message: 'Snapshot taken!', reload_data: true)
  end
end
