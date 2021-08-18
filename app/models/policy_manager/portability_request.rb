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

require 'paperclip'

module PolicyManager
  class PortabilityRequest < ActiveRecord::Base
    include Paperclip::Glue
    include PolicyManager::Concerns::WorksWithJob

    belongs_to :user, class_name: Config.user_resource.to_s
    has_many :logs, as: :loggable

    after_create -> { log_portability_requests(PolicyManager::Concerns::WorksWithJob::JobStatues::PROCESSING) }
    after_save :log_after_save

    has_attached_file :attachment,
                      path: ':rails_root/private/policy_manager/portability_requests/:id/:basename.:extension',
                      url: '/:class/:id/:attachment',
                      content_type: 'text/plain'

    do_not_validate_attachment_file_type :attachment

    scope :of_user, ->(user) { where(user_id: user.id) }
    
    def log_after_save
      log_portability_requests(PolicyManager::Concerns::WorksWithJob::JobStatues::COMPLETED) if self.job_completed?
      log_portability_requests(PolicyManager::Concerns::WorksWithJob::JobStatues::FAILED) if self.job_failed?
    end

    def log_portability_requests(state)
      case state
      when PolicyManager::Concerns::WorksWithJob::JobStatues::PROCESSING
        Log.create(
          log_type: Log::LogTypes::INFO,
          description: 'Created new portability request',
          loggable: self,
          user_id: self.user_id
        )
      when PolicyManager::Concerns::WorksWithJob::JobStatues::FAILED
        Log.create(
          log_type: Log::LogTypes::ERROR,
          description: 'Portability request failed',
          loggable: self,
          user_id: self.user_id
        )
      when PolicyManager::Concerns::WorksWithJob::JobStatues::COMPLETED
        Log.create(
          log_type: Log::LogTypes::INFO,
          description: 'Portability request completed successfully',
          loggable: self,
          user_id: self.user_id
        )
      end
    end
  end
end
