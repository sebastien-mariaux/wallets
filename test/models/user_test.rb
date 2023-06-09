# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  precision              :integer          default(6)
#  investment             :decimal(, )      default(0.0)
#  display_main           :boolean          default(TRUE)
#  main_currency          :string           default("eur")
#  display_secondary      :boolean
#  display_tertiary       :boolean
#  secondary_currency     :text
#  tertiary_currency      :text
#  investment_currency    :text
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_inclusion_of(:main_currency).in_array(User::SUPPORTED_CURRENCIES)
end
