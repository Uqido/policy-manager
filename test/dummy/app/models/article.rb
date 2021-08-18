# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string
#  user_id     :integer
#  subtitle    :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Article < ActiveRecord::Base
  belongs_to :user
end
