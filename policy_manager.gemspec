$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "policy_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "policy_manager"
  s.version     = PolicyManager::VERSION
  s.authors     = ["Uqido"]
  s.email       = ["teslaruzero@gmail.com"]
  # s.homepage    = "TODO"
  s.summary     = %q{A gem to manage your GDPR policies}
  # s.description = "TODO: Description of PolicyManager."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2.7"

  s.add_development_dependency "sqlite3"
end
