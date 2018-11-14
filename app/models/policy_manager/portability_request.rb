require "paperclip"

module PolicyManager
  class PortabilityRequest < ActiveRecord::Base
    include Paperclip::Glue

    belongs_to :user, class_name: Config.user_resource.to_s

    has_attached_file :attachment,
                      path: ":rails_root/private/policy_manager/portability_requests/:id"

    do_not_validate_attachment_file_type :attachment

    scope :of_user, ->(user) { where(user_id: user.id) }
  end
end
