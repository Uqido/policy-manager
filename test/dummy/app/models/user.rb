class User < ActiveRecord::Base
  include PolicyManager::Concerns::WithPolicies

  has_many :articles

  def is_admin?
    self.email == 'test@test.com'
  end
end
