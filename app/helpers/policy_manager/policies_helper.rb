module PolicyManager
  module PoliciesHelper
    def policies_check_text
      t('policies.index.registration_check',
        terms: link_to(t('policies.index.terms_of_service'), policy_manager.policy_path(Policy.newer(Policy::PolicyTypes::TOS)), target: '_blank'),
        privacy: link_to(t('policies.index.privacy'), policy_manager.policy_path(Policy.newer(Policy::PolicyTypes::PRIVACY)), target: '_blank'),
        cookie: link_to(t('policies.index.cookie'), policy_manager.policy_path(Policy.newer(Policy::PolicyTypes::COOKIE)), target: '_blank')).html_safe
    end
  end
end
