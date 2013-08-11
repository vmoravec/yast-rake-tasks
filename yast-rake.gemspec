lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yast/rake/version'

Gem::Specification.new do |gem|
  gem.name          = "yast-rake"
  gem.version       = Yast::Rake::VERSION
  gem.authors       = ["The YaST Team"]
  gem.email         = ["yast-devel@opensuse.org"]
  gem.description   = %q{Rake extension for yast}
  gem.summary       = %q{Rake configuration and tasks for YaST development}
  gem.homepage      = "https://github.com/yast/yast-rake"

  gem.files         = Dir["lib/**/*.{rake,rb}",'Rakefile','LICENSE','VERSION']
  gem.require_paths = ["lib"]

  gem.add_dependency 'rake'
end
