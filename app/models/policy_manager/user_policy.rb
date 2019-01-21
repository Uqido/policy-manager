module PolicyManager
  class UserPolicy < ApplicationRecord
    belongs_to :user, class_name: Config.user_resource.to_s
    belongs_to :policy
    has_many :logs, as: :loggable

    validates_uniqueness_of :policy_id, scope: :user_id

    after_save :log_user_policies

    private

      def log_user_policies
        Log.create(
          log_type: Log::LogTypes::INFO,
          description: "User #{(self.accepted ? ' accepted ' : ' rejected ') +
              self.policy.policy_type} policy (version #{self.policy.version})",
          loggable: self,
          user_id: self.user_id
        )
      end
  end
end
