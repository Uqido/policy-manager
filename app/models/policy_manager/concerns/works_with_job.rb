require 'active_support/concern'

module PolicyManager
  module Concerns
    module WorksWithJob
      extend ActiveSupport::Concern

      included do
        scope :processing, -> { (where(job_completed_at: nil, job_failed_at: nil)) }
        scope :completed, -> { (where.not(job_completed_at: nil)) }
        scope :failed, -> { (where.not(job_failed_at: nil)) }

        module JobStatues
          PROCESSING = 'processing'
          FAILED     = 'failed'
          COMPLETED  = 'completed'
        end
      end

      module ClassMethods
        # ...
      end

      def job_completed?
        job_completed_at.present?
      end

      def job_processing?
        !self.job_completed? && !self.job_failed?
      end

      def job_failed?
        job_failed_at.present?
      end

      def job_status
        if self.job_completed?
          'completed'
        elsif self.job_failed?
          'failed'
        else
          'processing'
        end
      end

      def mark_as_complete
        self.update(job_completed_at: DateTime.now)
      end

      def mark_as_failed
        self.update(job_failed_at: DateTime.now)
      end
    end
  end
end
