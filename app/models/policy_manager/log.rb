module PolicyManager
  class Log < ActiveRecord::Base
    module LogTypes
      INFO  = 'info'.freeze
      ERROR = 'error'.freeze
    end

    belongs_to :logable, polymorphic: true
    belongs_to :user, class_name: Config.user_resource.to_s

    scope :info_logs, -> { where(log_type: LogTypes::INFO) }
    scope :error_logs, -> { where(log_type: LogTypes::ERROR) }

    validates_presence_of :log_type, :description
  end
end
