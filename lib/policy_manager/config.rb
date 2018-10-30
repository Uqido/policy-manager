module PolicyManager
  class Config

    mattr_accessor :logout_url,
                   :user_resource


    def self.setup
      yield self

      # sets this defaults after configuration
      @@user_resource ||= 'User'

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
  end
end
