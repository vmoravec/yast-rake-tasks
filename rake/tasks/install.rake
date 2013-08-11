task(:install).clear


desc "Create a gem file and install it locally"
task :install do
  puts "Going to build the gem now..."
  Rake::Task['build:gem'].invoke
  gem = rake.config.gem
  puts "\nGoing to install the gem now.."
  sh "gem install #{gem.path}"
end
