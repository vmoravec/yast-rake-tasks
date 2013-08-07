namespace :package do
  desc "Information about the package"
  task :info do
    puts rake.package.name
    puts rake.package.version
    puts rake.package.maintainer
  end

  desc "Create a package"
  task :create do
    puts "Creating a new package"
  end

end

task :package => :"package:info"
