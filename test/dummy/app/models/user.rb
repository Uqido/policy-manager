# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  include PolicyManager::Concerns::WithPolicies

  has_many :articles

  def is_admin?
    self.email == 'test@test.com'
  end
end
