# frozen_string_literal: true

require 'builders/snapshot_builder'

class SnapshotCreateJob < ApplicationJob
  def perform(user, process)
    builder = Builders::SnapshotBuilder.new(user)
    builder.build
    process.reload.update!(status: 'done', message: 'Snapshot taken!', reload_data: true)
  end
end
