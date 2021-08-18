# == Schema Information
#
# Table name: policy_manager_portability_requests
#
#  id                           :integer          not null, primary key
#  user_id                      :integer
#  attachment                   :string
#  attachment_file_name         :string
#  attachment_file_size         :string
#  attachment_content_type      :string
#  attachment_file_content_type :string
#  job_completed_at             :datetime
#  job_failed_at                :datetime
#  created_at                   :datetime
#  updated_at                   :datetime
#

require 'test_helper'

module PolicyManager
  class PortabilityRequestTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
