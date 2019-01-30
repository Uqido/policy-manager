PolicyManager::Config.setup do |c|
  c.user_resource = User # defaults to User

  c.add_policy(
    name: 'The Cookie Policy',
    policy_type: PolicyManager::Policy::PolicyTypes::COOKIE,
    content: '<p> This is the Cookie Policy</p>', # TODO: can this be an html file?
    version: 1,
    blocking: false
  )

  c.add_policy(
    name: 'The Privacy Policy',
    policy_type: PolicyManager::Policy::PolicyTypes::PRIVACY,
    content: '<p> This is the Privacy Policy</p>',
    version: 1,
    blocking: true
  )
  c.add_policy(
    name: 'The Privacy Policy',
    policy_type: PolicyManager::Policy::PolicyTypes::PRIVACY,
    content: '<p> This is the Privacy Policy</p>',
    version: 2,
    blocking: true
  )

  c.is_admin_method = ->(user) {
    user.is_admin? if user
  }

  c.portability_map = [
    :email,
    articles: [:title, :subtitle, :description]
  ]
end
