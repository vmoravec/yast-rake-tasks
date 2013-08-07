require 'pathname'

module Yast
  module Rake
    module Tasks
      version_file = File.expand_path('../../../../VERSION', __FILE__)
      VERSION   = File.read(version_file).strip
      TASKS_DIR = Pathname.new(File.dirname(__FILE__)).join 'tasks'

      def self.version
        VERSION
      end

      def self.import *tasks
        tasks.each do |rake_task|
          ::Rake.application.add_import discover_task(rake_task)
        end
      end

      private

      def self.discover_task task_name
        task_file = TASKS_DIR.join("#{task_name}.rake").expand_path
        abort "Task '#{task_name}' not found." unless File.exists? task_file
        task_file
      end
    end
  end
end
