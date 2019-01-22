module PolicyManager
  class BulkUpdateUserPolicies
    attr_accessor :user
    attr_accessor :user_policies_attributes

    def initialize(attributes)
      user_id = attributes['user_id']
      user_policies_hash = attributes['user_policies']

      @user = User.find(user_id)
      @user_policies_attributes = user_policies_hash.keys.map do |pos|
        user_policies_hash[pos]
      end
    end

    def call
      updated = []
      @user_policies_attributes.each do |policy_attributes|
        UserPolicy.where(policy_id: policy_attributes[:policy_id], user: @user)
          .first_or_create
          .update(policy_attributes.permit(:policy_id, :accepted))
        updated << UserPolicy.where(policy_id: policy_attributes[:policy_id], user: @user)
          .first
      end
      updated
    end
  end
end
