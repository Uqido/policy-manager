module PolicyManager
  class BulkUpdateUserPolicies
    attr_accessor :attributes

    def initialize(attributes = [])
      @attributes = attributes
    end

    def call
      @attributes.each do |policy_attributes|
        UserPolicy.find(policy_attributes[:id]).update(policy_attributes)
      end
    end
  end
end
