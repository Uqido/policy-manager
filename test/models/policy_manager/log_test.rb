# == Schema Information
#
# Table name: policy_manager_logs
#
#  id            :integer          not null, primary key
#  log_type      :string
#  description   :string
#  loggable_id   :integer
#  loggable_type :string
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

module PolicyManager
  class LogTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
