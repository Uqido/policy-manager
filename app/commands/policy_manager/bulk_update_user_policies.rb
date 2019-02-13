module PolicyManager
  class BulkUpdateUserPolicies
    attr_accessor :user
    attr_accessor :user_policies_attributes

    def initialize(attributes)
      @user = User.find(attributes[:user_id])
      @user_policies = attributes[:user_policies]
    end

    def call
      updated = []
      @user_policies.each do |policy_attributes|
        UserPolicy.where(policy_id: policy_attributes[:policy_id], user: @user)
          .first_or_create
          .update(policy_attributes)
        updated << UserPolicy.where(policy_id: policy_attributes[:policy_id], user: @user)
          .first
      end
      updated
    end
  end
end
