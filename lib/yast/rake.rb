require 'pathname'
require 'yast/rake/options'

module Yast
  module Rake

    def rake
      @rake ||= Options.get
    end

  end
end

self.extend Yast::Rake

require 'yast/rake/tasks'

Yast::Rake::Tasks.import
