namespace :check do

  desc "Default task for rake:check"
  task :all do
    Rake::Task['check:syntax'].invoke
    Rake::Task['check:package'].invoke
  end

  desc "Check syntax of *.{rb,rake} files"
  task :syntax do
    ok_message_offset = " " * 100
    Dir["#{rake.config.root}/**/*.{rb,rake}"].each do |file|
      print "   #{file}#{ok_message_offset[0..(ok_message_offset.size - file.to_s.size)]}"
      system "ruby -wc #{file}"
    end
  end

  desc "Check package code completness"
  task :package do
    rake.config.package.run_checks
  end


  desc "Docs for check task"
  task :help do
    puts "Empty docs so far"
  end
end

task :check => 'check:all'
