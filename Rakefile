lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'yast/rake'

Yast::Rake.domain = 'yast-rake-tasks'
# Yast::Rake.config do |config|
#   config.domain = 'yast-rake-tasks'
# end
Yast::Rake::Tasks.import :check_syntax, :package, :buildrpm, :osc
