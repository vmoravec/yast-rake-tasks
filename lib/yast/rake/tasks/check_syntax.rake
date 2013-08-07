desc "Check syntax of all files with *.rb and *.rake extension"
task :check_syntax do
  puts " Starting the syntax checking task..."
  offset = " " * 60
  Dir["**/*.{rb,rake}"].each do |file|
    print "   #{file}#{offset[0..(offset.size - file.to_s.size)]}"
    system "ruby -c #{file}"
  end
end
