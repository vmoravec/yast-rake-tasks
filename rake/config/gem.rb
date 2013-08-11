module Yast::Rake::Config
  module Gem
    attr_reader :package

    def setup
      @package = rake.config.package
    end

    def path
      package.dir.join package.dir, self.name
    end

    def name
      "#{package.name}-#{package.version}.gem"
    end
  end
end

