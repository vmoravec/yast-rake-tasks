module Yast::Rake::Config
  module Package
    PREFIX      = 'yast-'
    TARGET_DIR  = 'package/'
    LICENSE_DIR = 'license/'

    class Files
      INSTALL = [
        'src/',
        LICENSE_DIR,
        'config/'
      ]

      PACKAGE = [
        'test/',
        'spec/',
        'rake/',
        'Rakefile'
      ]

      IGNORE = [
        TARGET_DIR,
        'coverage/',
        'doc/'
      ]

      attr_reader :rake

      def initialize rake
        @rake = rake
      end

      def all
        Dir["#{rake.config.root}/**/*"]
      end

      def desktop
        Dir["#{rake.config.root.join '/src/desktop'}"]
      end

      def clients
      end

      def config
      end

      def modules
      end

      def test
      end

      def src
      end

      def package
      end
    end

    attr_reader   :version, :name, :maintainer, :files
    attr_accessor :domain

    def setup
      @version = read_version_file
      @name    = read_rpmname_file
      @excluded_files = []
      @files   = Files.new(rake)
      @domain  = domain_from_rpmname_file
    end

    def exclude_file path
      @excluded_files << rake.config.root.join(path)
    end

    private

    def read_version_file
      file_path = rake.config.root.join 'VERSION'
      read_file(file_path)
    end

    def read_file file
      if File.exists?(file)
        read_content(file)
      else
        errors << "Mandatory file '#{file}' not found."
        nil
      end
    end

    def read_rpmname_file
      file_path = rake.config.root.join 'RPMNAME'
      read_file(file_path)
    end

    def domain_from_rpmname_file
      name.to_s.split(PREFIX).last
    end

    def read_maintainer_file ; end
    def read_readme_file     ; end
    def read_spec_file       ; end
    def read_changes_file    ; end

    def read_content file
      content = File.read(file).strip
      errors.push("File '#{file}' must not be empty.\nAborting rake..") if content.size.zero?
      content
    end
  end
end
