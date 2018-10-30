module PolicyManager
  class UserPolicy < ApplicationRecord
    belongs_to :user, class_name: Config.user_resource.to_s
    belongs_to :policy

    validates_uniqueness_of :policy_id, scope: :user_id
  end
end
