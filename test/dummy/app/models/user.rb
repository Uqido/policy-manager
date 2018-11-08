class User < ActiveRecord::Base
  include PolicyManager::Concerns::WithPolicies

  def is_admin?
    self.email == 'teslaruzero@gmail.com'
  end
end
