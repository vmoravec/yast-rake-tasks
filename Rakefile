lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'yast/rake'

require_relative 'rake/config/gem'

rake.config.register Yast::Rake::Config::Gem

import 'rake/tasks/build.rake'
import 'rake/tasks/install.rake'
