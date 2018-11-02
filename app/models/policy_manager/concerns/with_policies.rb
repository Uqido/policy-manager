module PolicyManager
  module Concerns
    module WithPolicies
      extend ActiveSupport::Concern

      included do
        begin
          has_many :user_policies, class_name: "PolicyManager::UserPolicy", autosave: true
          has_many :policies, through: :user_policies, class_name: "PolicyManager::Policy"

          PolicyManager::PolicyHelper.signable_policies.each do |policy|
            define_method :"has_consented_#{policy.policy_type}?" do
              user_policy = PolicyManager::UserPolicy.find_by(policy_id: policy.id)

              user_policy ? user_policy.accepted : false
            end

            define_method :"accept_#{policy.policy_type}_policy" do
              user_policy = PolicyManager::UserPolicy.find_by(policy_id: policy.id, user_id: self.id)

              if user_policy
                user_policy.update(accepted: true)
              else
                PolicyManager::UserPolicy.create(policy_id: policy.id, user_id: self.id, accepted: true)
              end
            end

            define_method :"reject_#{policy.policy_type}_policy" do
              user_policy = PolicyManager::UserPolicy.find_by(policy_id: policy.id, user_id: self.id)

              if user_policy
                user_policy.update(accepted: false) if user_policy.accepted
              else
                PolicyManager::UserPolicy.create(policy_id: policy.id, user_id: self.id, accepted: false)
              end
            end
          end
        rescue ActiveRecord::StatementInvalid => e
          PolicyManager::PolicyHelper.errors e
        end
      end

    end
  end
end