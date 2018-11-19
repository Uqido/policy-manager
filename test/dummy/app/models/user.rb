class User < ActiveRecord::Base
  include PolicyManager::Concerns::WithPolicies

  def is_admin?
    self.email == 'test@test.com'
  end
end
