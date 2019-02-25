# == Schema Information
#
# Table name: policy_manager_policies
#
#  id          :integer          not null, primary key
#  name        :string
#  policy_type :string
#  content     :text
#  version     :integer
#  blocking    :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module PolicyManager
  class Policy < ApplicationRecord
    module PolicyTypes
      COOKIE  = 'cookie'.freeze
      PRIVACY = 'privacy'.freeze
      TOS = 'terms_of_service'.freeze
      MARKETING = 'marketing'.freeze
      TYPES = %w[cookie privacy terms_of_service marketing].freeze
    end
    module PolicyActions
      CREATED  = 'created'.freeze
      UPDATED  = 'updated'.freeze
      DELETED  = 'deleted'.freeze
    end

    validates_presence_of :name
    validates_presence_of :policy_type
    validates_presence_of :content
    validates_presence_of :version

    validates_uniqueness_of :version, scope: :policy_type

    after_create -> { log_policies(PolicyManager::Policy::PolicyActions::CREATED) }
    after_update -> { log_policies(PolicyManager::Policy::PolicyActions::UPDATED) }
    after_destroy -> { log_policies(PolicyManager::Policy::PolicyActions::DELETED) }

    scope :newer, ->(type) { where(policy_type: type).order(version: :desc).first }

    def to_html
      content.html_safe
    end

    def self.signable_policies
      result = []
      Policy.uniq.pluck(:policy_type).each do |policy_type|
        result << Policy.newer(policy_type)
      end

      result
    end

    def self.migration_missing_errors(e)
      puts '-------------------------------------------------------------------------------------------'
      puts 'Remember to run rake policy_manager:install:migrations and to run the generated migrations'
      puts '-------------------------------------------------------------------------------------------'
      puts "Exception Class: #{e.class.name}"
      puts "Exception Message: #{e.message}"
    end

    private

      def log_policies(action)
        Log.create(
          log_type: Log::LogTypes::INFO,
          description: "#{self.name}(#{self.policy_type}) was successfully #{action}",
          loggable: self
        )
      end
  end
end
