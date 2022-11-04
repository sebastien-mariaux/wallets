# frozen_string_literal: true

class EnablePgcryptoExtension < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' if %w[development test].include?(Rails.env)
  end
end
