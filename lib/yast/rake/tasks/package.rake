namespace :package do
  desc "Information about the package"
  task :info do
    puts rake.options.package.name
    puts rake.options.package.version
    puts rake.options.package.maintainer
  end

  desc "Create a package"
  task :create do
    puts "Creating a new package"
  end

end

task :package => :"package:info"
