module Yast::Rake::Config
  module Package
    PREFIX          = 'yast-'

    VERSION_FILE    = 'VERSION'
    RPMNAME_FILE    = 'RPMNAME'
    MAINTAINER_FILE = 'MAINTAINER'
    README_FILE     = 'README'

    PACKAGE_DIR     = 'package'
    LICENSE_DIR     = 'license'
    CONFIG_DIR      = 'config'
    RAKE_DIR        = 'rake'
    TEST_DIR        = 'test'
    COVERAGE_DIR    = 'coverage'
    DOC_DIR         = 'doc'

    # code
    SRC_DIR = 'src'
    DESKTOP_DIR = SRC_DIR + '/desktop'
    MODULES_DIR = SRC_DIR + '/modules'
    CLIENTS_DIR = SRC_DIR + '/clients'
    INCLUDE_DIR = SRC_DIR + '/include'

    class Files

      def initialize rake
        @rake = rake
      end

      def all
        Dir["#{root_dir}/**/*"]
      end

      def desktop
        Dir["#{root_dir.join DESKTOP_DIR}/*.desktop"]
      end

      def clients
        Dir["#{root_dir.join CLIENTS_DIR}"]
      end

      def changes
        Dir["#{root_dir.join PACKAGE_DIR}/.changes'"]
      end

      def config
        Dir["#{root_dir.join CONFIG_DIR}/**/*"]
      end

      def modules
        Dir["#{root_dir.join MODULES_DIR}/**/*"]
      end

      def test
        Dir["#{root_dir.join TEST_DIR}/**/*"]
      end

      def src
        Dir["#{root_dir.join SRC_DIR}/**/*"]
      end

      def package
        Dir["#{root_dir.join PACKAGE_DIR}/**/*"]
      end

      def inspect
        all.join "\n"
      end

      private

      def root_dir
        @rake.config.root
      end
    end

    attr_reader   :version, :name, :maintainer, :files
    attr_accessor :domain

    def setup
      @version = read_version_file
      @name    = read_rpmname_file
      @excluded_files = []
      @domain  = domain_from_rpmname
      @files   = Files.new(rake)
    end

    def dir
      @dir ||= rake.config.root.join 'package'
    end

    def exclude_file path
      @excluded_files << rake.config.root.join(path)
    end

    private

    def read_version_file
      file_path = rake.config.root.join VERSION_FILE
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
      file_path = rake.config.root.join RPMNAME_FILE
      read_file(file_path)
    end

    def domain_from_rpmname
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
