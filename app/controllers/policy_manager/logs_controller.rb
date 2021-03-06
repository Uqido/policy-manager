require_dependency 'policy_manager/application_controller'

module PolicyManager
  class LogsController < ApplicationController
    before_action :user_authenticated?
    before_action :allow_admins

    def index
      @logs = Log.all.page(params[:page])
    end
  end
end