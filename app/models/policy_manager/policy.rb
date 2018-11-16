module PolicyManager
  class Policy < ApplicationRecord

    module PolicyTypes
      COOKIE  = 'cookie'
      PRIVACY = 'privacy'
      TYPES = ['cookie', 'privacy']
    end

    validates_presence_of :policy_type
    validates_presence_of :content
    validates_presence_of :version

    validates_uniqueness_of :version, scope: :policy_type

    def to_html
      content.html_safe
    end
  end
end