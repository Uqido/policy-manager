module PolicyManager
  class Config
    mattr_accessor :user_resource,
                   :admin_user_resource,
                   :is_admin_method,
                   :portability_map

    def self.setup
      yield self

      # sets this defaults after configuration
      @@user_resource ||= User
      @@admin_user_resource ||= User
      @@portability_map ||= {}

      self
    end

    def self.add_policy(opts = {})
      PolicyManager::Policy.where(name: opts[:name], policy_type: opts[:policy_type], version: opts[:version]).first_or_create! do |policy|
        policy.attributes = {
          name: opts[:name],
          policy_type: opts[:policy_type],
          version: opts[:version],
          content: opts[:content],
          blocking: opts[:blocking]
        }
      end
    rescue ActiveRecord::StatementInvalid => e
      PolicyManager::Policy.migration_missing_errors e
    rescue ActiveRecord::RecordInvalid => e
      puts '-------------------------------------------------------------------------------------------'
      puts 'PolicyManager Configuration Invalid. Please review your initializer                        '
      puts '-------------------------------------------------------------------------------------------'
      puts "Exception Class: #{e.class.name}"
      puts "Exception Message: #{e.message}"
    end

    def self.is_admin?(user)
      if has_different_admin_user_resource?
        user.is_a? admin_user_resource
      else
        raise Rails.logger.error('PolicyManager ERROR! please add is_admin_method to your initializer') if is_admin_method.blank?
        is_admin_method.call(user)
      end
    end

    def self.has_different_admin_user_resource?
      user_resource != admin_user_resource
    end
  end
end
