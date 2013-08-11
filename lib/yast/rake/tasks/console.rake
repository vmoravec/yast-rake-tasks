desc "Start irb session with yast/rake loaded"
task :console do
  require 'irb'
  ARGV.clear # needed to avoid exception "No such file or directory - console"
  IRB.start
end

#TODO add rake.config.console.reload! method or reload!
