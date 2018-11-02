require_dependency "policy_manager/application_controller"

module PolicyManager
  class PoliciesController < ApplicationController
    before_action :set_policy, only: [:show]

    def show
    end

    private

    def set_policy
      @policy = Policy.find(params[:id])
    end
  end
end
