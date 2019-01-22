require_dependency 'policy_manager/application_controller'

module PolicyManager
  class UserPoliciesController < ApplicationController
    before_action :user_authenticated?
    before_action :set_user_policy, only: [:update]

    def index
      render :index, layout: false
    end

    def create
      UserPolicy.create(user_policy_params)

      render nothing: true
    end

    def update
      @user_policy.update(user_policy_params)

      render nothing: true
    end

    def bulk_update
      updated = BulkUpdateUserPolicies.new(bulk_user_policy_params).call

      respond_to do |format|
        format.json { render json: updated.map { |u| u.as_json(only: [:policy_id, :accepted]) } }
      end
    end

    private

      def set_user_policy
        @user_policy = UserPolicy.find(params[:id])
      end

      def user_policy_params
        params.require(:user_policy).permit(:policy_id, :accepted).merge(user_id: current_user.id)
      end

      def bulk_user_policy_params
        params.merge(user_id: current_user.id)
      end
  end
end
