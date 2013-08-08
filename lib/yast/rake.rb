require 'pathname'
require 'yast/rake/options'

module Yast
  module Rake

    def rake
      @rake ||= Options
    end

  end
end

# extend the main object with rake method to work with it
# directly from the Rakefile
self.extend Yast::Rake

# needed for the default.rake task to record tasks metadata
Rake::TaskManager.record_task_metadata = true

require 'yast/rake/tasks'

# load all tasks;
# directories to be scanned for rake tasks
# default tasks: lib/yast/rake/tasks
# package tasks: package/dir/rake/tasks
Yast::Rake::Tasks.import
