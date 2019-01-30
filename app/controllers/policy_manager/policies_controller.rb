require_dependency 'policy_manager/application_controller'

module PolicyManager
  class PoliciesController < ApplicationController
    before_action :user_authenticated?, except: [:show]
    before_action :allow_admins, except: [:show]
    before_action :set_policy, only: [:show, :edit, :update, :destroy]

    def show
      @edit_mode = Config.is_admin? current_user if current_user
    end

    def index
      @policies = Policy.all
    end

    def new
      @policy = Policy.new
    end

    def edit; end

    def create
      @policy = Policy.new(policy_params)

      if @policy.save
        redirect_to policies_path, notice: t('policies.new.policy_created')
      else
        render :new
      end
    end

    def update
      if @policy.update(policy_params)
        redirect_to policies_path, notice: t('policies.edit.policy_updated')
      else
        render :edit
      end
    end

    def destroy
      @policy.destroy
      redirect_to policies_path, notice: t('policies.index.policy_destroyed')
    end

    private

    def set_policy
      @policy = Policy.find(params[:id])
    end

    def policy_params
      params.require(:policy).permit(:name, :policy_type, :content, :version, :blocking)
    end
  end
end
