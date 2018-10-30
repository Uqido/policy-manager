module PolicyManager
  module PolicyHelper

    def self.signable_policies
      result = []
      PolicyManager::Policy.uniq.pluck(:policy_type).each do |policy_type|
        result << PolicyManager::Policy.where(policy_type: policy_type).order(version: :desc).first
      end

      result
    end

    def self.errors(e)
      puts '-------------------------------------------------------------------------------------------'
      puts 'Remember to run rake policy_manager:generate_migrations and to run the generated migrations'
      puts '-------------------------------------------------------------------------------------------'
      puts "Exception Class: #{ e.class.name }"
      puts "Exception Message: #{ e.message }"
    end
  end
end