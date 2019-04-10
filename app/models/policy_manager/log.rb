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

module PolicyManager
  class Log < ActiveRecord::Base
    module LogTypes
      INFO  = 'info'.freeze
      ERROR = 'error'.freeze
    end

    belongs_to :loggable, polymorphic: true
    belongs_to :user, class_name: Config.user_resource.to_s

    scope :info_logs, -> { where(log_type: LogTypes::INFO) }
    scope :error_logs, -> { where(log_type: LogTypes::ERROR) }

    validates_presence_of :log_type, :description
  end
end
