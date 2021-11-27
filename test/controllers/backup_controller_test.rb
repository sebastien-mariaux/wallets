# frozen_string_literal: true

require_relative './user_authenticated_controller_test'

class CoinsControllerTest < UserAuthenticatedControllerTest
  context 'run import' do
    should 'return process id' do
      get import_backup_path
      assert_response :success
      process = assigns(:app_process)
      assert_equal process.id, JSON.parse(response.body)['id']
    end

    should 'enqueued backup job' do
      assert_enqueued_jobs 1, only: ImportJob do
        get import_backup_path
      end
    end
  end

  context 'export' do
    should 'return process id' do
      get export_backup_path
      assert_response :success
      process = assigns(:app_process)
      assert_equal process.id, JSON.parse(response.body)['id']
    end

    should 'enqueued backup job' do
      assert_enqueued_jobs 1, only: ExportJob do
        get export_backup_path
      end
    end
  end
end
