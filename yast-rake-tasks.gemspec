lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yast-rake-tasks/version'

Gem::Specification.new do |gem|
  gem.name          = "yast-rake-tasks"
  gem.version       = Yast::Rake::Tasks::VERSION
  gem.authors       = ["The YaST Team"]
  gem.email         = ["yast-devel@opensuse.org"]
  gem.description   = %q{Shared Rake tasks for YaST}
  gem.summary       = %q{Rake tasks for YaST development}
  gem.homepage      = "https://github.com/yast/yast-rake-tasks"

  gem.files         = Dir["lib/**/*.{rake,rb}",'Rakefile','LICENSE','VERSION']
  gem.require_paths = ["lib"]

  gem.add_dependency 'rake'
end
