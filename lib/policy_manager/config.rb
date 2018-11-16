module PolicyManager
  class Config

    mattr_accessor :logout_url,
                   :user_resource,
                   :admin_user_resource,
                   :is_admin_method


    def self.setup
      yield self

      # sets this defaults after configuration
      @@user_resource ||= User
      @@admin_user_resource ||= User

      self
    end

    def self.add_policy(opts = {})
      begin
        PolicyManager::Policy.where(policy_type: opts[:policy_type], version: opts[:version]).first_or_create do |policy|
          policy.policy_type  = opts[:policy_type]
          policy.version      = opts[:version]
          policy.content      = opts[:content]
          policy.blocking     = opts[:blocking]
        end
      rescue ActiveRecord::StatementInvalid => e
        PolicyManager::PolicyHelper.errors e
      end
    end

    def self.is_admin?(user)
      if has_different_admin_user_resource?
        user.is_a? admin_user_resource
      else
        raise Rails.logger.error("PolicyManager ERROR! please add is_admin_method to your initializer") if @@is_admin_method.blank?
        @@is_admin_method.call(user)
      end
    end

    def self.has_different_admin_user_resource?
      user_resource != admin_user_resource
    end

  end
end
