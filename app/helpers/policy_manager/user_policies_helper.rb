module PolicyManager
  module UserPoliciesHelper

    def user_policies_list(current_user)
      render 'policy_manager/user_policies/user_policies', current_user: current_user
    end

  end
end