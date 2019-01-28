module PolicyManager
  class ApplicationController < ::ApplicationController # inherits from the main application controller
    skip_before_action :verify_authenticity_token

    def allow_admins
      render file: 'policy_manager/401.erb', status: :unauthorized unless Config.is_admin?(current_user)
    end

    def user_authenticated?
      render file: 'policy_manager/401.erb', status: :unauthorized unless current_user
    end

    def current_user
      @_current_user ||= super || (Config.has_different_admin_user_resource? && admin_user)
    end

    def admin_user
      self.send("current_#{Config.admin_user_resource.name.underscore}")
    end
  end
end
