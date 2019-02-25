## PolicyManager ~ Make GDPR great again !

![policy_manager](https://media.giphy.com/media/14rq7jizqq3oeQ/giphy.gif)

## About this project

PolicyManager was created to comply with the requirements of the GDPR.
It's currently being developed at Uqido and will be battle-tested on Uqido's projects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'policy_manager', git: 'git@github.com:Uqido/policy-manager.git'
```

And then execute to install it:

    $ bundle install

Install and run the needed migrations:

    $ rake policy_manager:install:migrations
    $ rake db:migrate

## Usage

### Layout

In order to use main application layouts it is mandatory to prefix wth `main_app` all the main application paths contained
inside the layouts. For example `root_path` will become `main_app.root_path`.

This is because otherwise when navigating gem paths it will try to find the main applications paths inside the gem routes
without (obviously) finding them.

### Basic config

In /config/initializers/policy_manager.rb do:

    PolicyManager::Config.setup do |c|
      c.user_resource = User # defaults to User
    
      c.add_policy({
                     name: 'The Cookie Policy',
                     policy_type: PolicyManager::Policy::PolicyTypes::COOKIE,
                     content: 'your html here',
                     version: 1,
                     blocking: false
                 })
    
      c.add_policy({
                     name: 'The Privacy Policy',
                     policy_type: PolicyManager::Policy::PolicyTypes::PRIVACY,
                     content: 'your html here',
                     version: 1,
                     blocking: true
                 })
       
      c.is_admin_method = -> (user) { 
        user.admin? || user.superadmin?
      } 
      
      c.portability_map = [
        :email,
        articles: [:title, :subtitle, :description]
      ]
    end

**Important:** Policies are translated using the [Globalize](https://github.com/globalize/globalize) gem. By creating them via config
it's implied that `name` and `content` will be for the current `I18n.locale`. If you want to 
create policies for a specific locale via config just wrap the `add_policy` method inside a
`I18n.with_locale(:your_locale)` block.

In your app router add the following:

    mount PolicyManager::Engine => "/policies"
    
Then add the concern to your `User` model:
    
    class User < ApplicationRecord
      include PolicyManager::Concerns::WithPolicies
    end
    
This will generate some helper methods on the `User` model. For example, with the example above you will
get the following methods for free:

- `@user.has_consented_cookie?`
- `@user.has_consented_privacy?`
- `@user.has_pending_policies?
- `@user.accept_cookie_policy`
- `@user.reject_cookie_policy`
- `@user.accept_privacy_policy`
- `@user.reject_privacy_policy`
- `@user.accept_policies`
### Helpers

If you want to use PolicyManager helpers within you application you have to 
import them in the **ApplicationController**: 

- ` helper PolicyManager::UserPoliciesHelper `
- ` helper PolicyManager::PoliciesHelper `

### Routes

The Policy Manager gem adds some custom routes to manage the policies.
A complete list of the available routes is available in the **Routing Error** page under 
the **Routes for PolicyManager::Engine** section.
## TODO

- [x] Consents acquisition with modal
- [x] User Data portability
- [x] Logs of operations made
- [ ] User Data deletion

## Contributing

To contribute just fork the repository and send a Pull Request. Tests would be nice !


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
