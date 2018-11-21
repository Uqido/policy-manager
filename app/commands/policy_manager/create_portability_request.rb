module PolicyManager
  class CreatePortabilityRequest

    attr_accessor :user,
                  :portability_request

    def initialize(user)
      @portability_request = PortabilityRequest.new(user: user)
      @user = user
    end

    def call
      ActiveRecord::Base.transaction do
        portability_request.save!

        ExporterJob.perform_later user.id, portability_request.id
      end
    end
  end
end