namespace :build do

  package = rake.config.package

  desc "Create a gem for yast-rake"
  task :gem do
    gem_name = "#{package.name}-#{package.version}.gem"
    sh "gem build #{package.name}.gemspec"
    mv gem_name, package.dir
    puts "Gem file is available now in #{package.dir.join gem_name}"
  end

  desc "Create an rpm package from gem"
  task :package do
    # implement creating the rpm package
  end
end
