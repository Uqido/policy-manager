require_dependency 'policy_manager/application_controller'

module PolicyManager
  class PortabilityRequestsController < ApplicationController

    before_action :set_portability_request, only: [:attachment]

    def index
      @portability_requests = PortabilityRequest.order(created_at: :desc).of_user current_user
    end

    def create
      if CreatePortabilityRequest.new(current_user).call
        redirect_to portability_requests_path, notice: t('portability_requests.confirmation')
      else
        redirect_to portability_requests_path, flash: { error: t('portability_requests.error') }
      end
    end

    def attachment
      send_file @portability_request.attachment.path,
                filename: @portability_request.attachment_file_name,
                type: @portability_request.attachment_content_type,
                disposition: 'attachment'
    end

    private

      def set_portability_request
        @portability_request = PortabilityRequest.find(params[:id])
      end
  end
end
