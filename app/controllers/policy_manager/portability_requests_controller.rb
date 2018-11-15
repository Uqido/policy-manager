require_dependency 'policy_manager/application_controller'

module PolicyManager
  class PortabilityRequestsController < ApplicationController
    before_action :set_portability_request, only: [:attachment]

    def index
      @portability_requests = PortabilityRequest.order(created_at: :desc).of_user current_user
    end

    def create
      @portability_request = PortabilityRequest.new

      # TODO: Call to something that starts the job

      json_obj = {}

      # TODO: Should rescue from errors and change the status to 'Failed'
      Config.portability_map.each_key do |key|
        json_obj[key.to_s] = []
        current_user.send(key).each do |elem|
          json_element = {}

          Config.portability_map[key].each do |field|
            json_element[field.to_s] = elem.send(field)
          end

          json_obj[key.to_s] << json_element
        end
      end

      file_name = "tmp/portability-request-data-#{Time.now.to_i}.txt"
      file = File.open(file_name, 'w') do |f|
        f << JSON.pretty_generate(json_obj)
      end


      @portability_request.attachment = File.new(file_name)


      @portability_request.user_id = current_user.id
      @portability_request.state = 'done'
      @portability_request.save


      File.delete(file_name)

      redirect_to portability_requests_path, notice: t('portability_requests.confirmation')
    end

    def attachment
      send_file @portability_request.attachment.path,
                filename: @portability_request.attachment_file_name,
                type: 'plain/text',
                disposition: 'attachment'
    end

    private

      def set_portability_request
        @portability_request = PortabilityRequest.find(params[:id])
      end
  end
end
