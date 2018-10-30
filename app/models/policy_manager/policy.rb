module PolicyManager
  class Policy < ApplicationRecord

    module PolicyTypes
      COOKIE  = 'cookie'
      PRIVACY = 'privacy'
    end

    validates_presence_of :policy_type
    validates_presence_of :content
    validates_presence_of :version

    validates_uniqueness_of :version

    def to_html
      content.html_safe
    end
  end
end