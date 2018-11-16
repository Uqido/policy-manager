module PolicyManager
  class Policy < ApplicationRecord
    module PolicyTypes
      COOKIE  = 'cookie'.freeze
      PRIVACY = 'privacy'.freeze
      TYPES = %w[cookie privacy].freeze
    end

    validates_presence_of :policy_type
    validates_presence_of :content
    validates_presence_of :version

    validates_uniqueness_of :version, scope: :policy_type

    def to_html
      content.html_safe
    end

    def self.signable_policies
      result = []
      Policy.uniq.pluck(:policy_type).each do |policy_type|
        result << Policy.where(policy_type: policy_type).order(version: :desc).first
      end

      result
    end

    def self.migration_missing_errors(e)
      puts '-------------------------------------------------------------------------------------------'
      puts 'Remember to run rake policy_manager:generate_migrations and to run the generated migrations'
      puts '-------------------------------------------------------------------------------------------'
      puts "Exception Class: #{e.class.name}"
      puts "Exception Message: #{e.message}"
    end
  end
end
