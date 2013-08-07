module Yast
  module Rake
    module Tasks
      TASKS_DIR = Pathname.new(File.dirname(__FILE__)).join 'tasks'

      def self.import tasks=[]
        tasks = list if tasks.empty?
        tasks.each do |rake_task|
          ::Rake.application.add_import discover_task(rake_task)
        end
      end

      def self.list
        Dir.glob("#{TASKS_DIR}/*.rake").map {|task| File.basename(task, '.rake') }
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
