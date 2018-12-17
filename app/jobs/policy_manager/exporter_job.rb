module PolicyManager
  class ExporterJob < ActiveJob::Base
    queue_as :default

    def perform(user_id, portability_request_id)
      result = {}
      user = Config.user_resource.find(user_id)
      portability_request = PortabilityRequest.find(portability_request_id)

      Config.portability_map.each_with_index do |key, index|
        case key
        when Symbol
          result[key.to_s] = user.send(key)
        when Hash
          key.each_key do |relation|
            result[relation.to_s] = []

            related_elements = []
            if relation.to_s.pluralize == relation.to_s # it is a has_many
              related_elements = user.send(relation)
            else # it is an 1 to 1
              related_elements << user.send(relation)
            end

            related_elements.each do |related_element|
              related_element_hash = {}

              Config.portability_map[index][relation].each do |field|
                related_element_hash[field.to_s] = related_element.send(field)
              end

              result[relation.to_s] << related_element_hash
            end
          end
        else
          result[key.to_s] = ''
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
    rescue StandardError => e
      portability_request.mark_as_failed if portability_request
      raise e
    end
  end
end
