require 'pathname'
require 'yast/rake/config'

module Yast
  module Rake

    def rake
      Config.load
    end

  end
end

# extend the main object with rake method to work with it
# directly from the Rakefile
self.extend Yast::Rake

# needed for the default.rake task to record tasks metadata
# must be set before loading the tasks
Rake::TaskManager.record_task_metadata = true

require 'yast/rake/tasks'

# load all tasks;
# directories to be scanned for rake tasks
# default tasks: lib/yast/rake/tasks
# package tasks: package/dir/rake/tasks
Yast::Rake::Tasks.import
