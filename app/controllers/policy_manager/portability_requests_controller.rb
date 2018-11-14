require_dependency "policy_manager/application_controller"

module PolicyManager
  class PortabilityRequestsController < ApplicationController

    def index
      @portability_requests = PortabilityRequest.of_user current_user
    end

    def create
      @portability_request = PortabilityRequest.new

      # TODO: Call to something that starts the job

      redirect_to portability_requests_path, notice: t('portability_requests.confirmation')
    end
  end
end
