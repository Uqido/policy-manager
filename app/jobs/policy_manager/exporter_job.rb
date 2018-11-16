module PolicyManager
  class ExporterJob < ActiveJob::Base
    queue_as :default

    def perform(user_id, portability_request_id)
      result = {}
      user = Config.user_resource.find(user_id)
      portability_request = PortabilityRequest.find(portability_request_id)

      Config.portability_map.each_key do |key|
        result[key.to_s] = []
        user.send(key).each do |elem|
          element = {}

          Config.portability_map[key].each do |field|
            element[field.to_s] = elem.send(field)
          end

          result[key.to_s] << element
        end
      end

      file_name = "tmp/portability-request-data-#{Time.now.to_i}.txt"

      File.open(file_name, 'w') do |f|
        f << JSON.pretty_generate(result)
      end

      portability_request.attachment = File.new(file_name)

      portability_request.mark_as_failed unless portability_request.save

      portability_request.mark_as_complete

      File.delete(file_name)

    rescue StandardError
      portability_request.mark_as_failed
    end
  end
end
