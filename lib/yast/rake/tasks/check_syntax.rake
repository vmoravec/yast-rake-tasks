desc "Check syntax of all files with *.rb and *.rake extension"
task :check_syntax do
  puts " Starting the syntax checking task..."
  offset = " " * 40
  Dir["**/*.{rb,rake}"].each do |file|
    print "   #{file}#{offset}"
    system "ruby -c #{file}"
  end
end
