module PolicyManager
  module Concerns
    module WithPolicies
      extend ActiveSupport::Concern

      included do
        begin
          has_many :user_policies, class_name: 'PolicyManager::UserPolicy', autosave: true
          has_many :policies, through: :user_policies, class_name: 'PolicyManager::Policy'

          Policy.signable_policies.each do |policy|

            define_method :"has_consented_#{policy.policy_type}?" do
              user_policy = UserPolicy.find_by(policy_id: policy.id)

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

          def has_pending_blocking_policies?
            Policy.signable_policies.select{|p| p.blocking}.each do |policy|
              return true unless send("has_consented_#{policy.policy_type}?")
            end

            false
          end
        rescue ActiveRecord::StatementInvalid => e
          Policy.migration_missing_errors e
        end
      end
    end
  end
end