$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'policy_manager/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'policy_manager'
  s.version     = PolicyManager::VERSION
  s.authors     = ['Uqido']
  s.email       = ['teslaruzero@gmail.com']
  s.summary     = 'A gem to manage your GDPR policies'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.11'
  s.add_dependency 'bootstrap-wysihtml5-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'paperclip'
  s.add_dependency 'kaminari'
  s.add_dependency 'globalize', '~> 5.0.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'annotate'
end
