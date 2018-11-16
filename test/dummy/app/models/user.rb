class User < ActiveRecord::Base

  def is_admin?
    self.email == 'teslaruzero@gmail.com'
  end
end
