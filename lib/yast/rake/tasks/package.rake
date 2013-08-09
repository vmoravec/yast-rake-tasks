namespace :package do
  desc "Information about the package"
  task :info do
    puts rake.config.package.name
    puts rake.config.package.version
    puts rake.config.package.maintainer
  end

  desc "Create a package"
  task :create do
    puts "Creating a new package"
  end

end

task :package => :"package:info"
