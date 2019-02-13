module PolicyManager
  module Concerns
    module WithPolicies
      extend ActiveSupport::Concern

      included do
        begin
          has_many :user_policies, class_name: 'PolicyManager::UserPolicy', autosave: true
          has_many :policies, through: :user_policies, class_name: 'PolicyManager::Policy'
          has_many :logs, class_name: 'PolicyManager::Log'

          after_destroy :log_after_destroy

          Policy.signable_policies.each do |policy|
            define_method :"has_consented_#{policy.policy_type}?" do
              user_policy = UserPolicy.find_by(policy_id: policy.id, user_id: self.id)

              user_policy ? user_policy.accepted : false
            end

            define_method :"accept_#{policy.policy_type}_policy" do
              user_policy = UserPolicy.find_or_initialize_by(policy_id: policy.id, user_id: self.id)

              user_policy.accepted = true
              user_policy.save
            end

            define_method :"reject_#{policy.policy_type}_policy" do
              user_policy = UserPolicy.find_or_initialize_by(policy_id: policy.id, user_id: self.id)

              user_policy.accepted = false
              user_policy.save
            end
          end

          def has_pending_policies?
            Policy.signable_policies.each do |policy|
              return true unless send("has_consented_#{policy.policy_type}?")
            end

            false
          end

          def has_pending_blocking_policies?
            Policy.signable_policies.select { |p| p.blocking }.each do |policy|
              return true unless send("has_consented_#{policy.policy_type}?")
            end

            false
          end

          def accept_policies ids
            return [] if ids.blank?

            results = []
            Policy.signable_policies.where(id: ids).each do |policy|
              results << self.send("accept_#{policy.policy_type}")
            end
            results
          end

          def delete_user_data
            yield self if block_given?

            self.destroy
          end

          def log_after_destroy
            Log.create(
              log_type: Log::LogTypes::INFO,
              description: 'A user has been deleted',
              loggable: self
            )
          end
        rescue ActiveRecord::StatementInvalid => e
          Policy.migration_missing_errors e
        end
      end
    end
  end
end
