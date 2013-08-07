namespace :check do

  desc "Check syntax of *.{rb,rake} files"
  task :syntax do
    ok_message_offset = " " * 100
    Dir["#{rake.root}/**/*.{rb,rake}"].each do |file|
      print "   #{file}#{ok_message_offset[0..(ok_message_offset.size - file.to_s.size)]}"
      system "ruby -wc #{file}"
    end
  end

  desc "Check package code completness"
  task :package do
    rake.package
    puts "Done. Code for package #{rake.package.name} seems to be all set."
  end

  task :default => :package
end
