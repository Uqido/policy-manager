require 'paperclip'

module PolicyManager
  class PortabilityRequest < ActiveRecord::Base
    include Paperclip::Glue
    include PolicyManager::Concerns::WorksWithJob

    belongs_to :user, class_name: Config.user_resource.to_s
    has_many :logs, as: :logable

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
          description: "Created portability request #{self.id}",
          logable: self,
          user_id: self.user_id
        )
      when PolicyManager::Concerns::WorksWithJob::JobStatues::FAILED
        Log.create(
          log_type: Log::LogTypes::ERROR,
          description: "Portability request #{self.id} failed",
          logable: self,
          user_id: self.user_id
        )
      when PolicyManager::Concerns::WorksWithJob::JobStatues::COMPLETED
        Log.create(
          log_type: Log::LogTypes::INFO,
          description: "Portability request #{self.id} completed successfully",
          logable: self,
          user_id: self.user_id
        )
      end
    end
  end
end
