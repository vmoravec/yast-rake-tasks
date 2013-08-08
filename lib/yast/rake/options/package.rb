module Yast::Rake::Options
  module Package
    TARGET_DIR  = 'package/'
    LICENSE_DIR = 'license/'
    PREFIX      = 'yast-'

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
    end

    def self.extended(settings)
      settings.setup
    end

    attr_reader   :version, :name, :maintainer, :excluded_files
    attr_accessor :domain

    def setup
   #  @version = read_version_file
   #  @name    = read_rpmname_file
      @excluded_files = []
      @files   = Files.new
      @domain  = domain_from_rpmname_file
    end

    def exclude_file path
      @excluded_files << options.root.join(path)
    end

    def inspect
      "[ #{(public_methods(false) - [:inspect]).join ', '} ]"
    end

    private

    def read_version_file
      file = rake.options.root.join 'VERSION'
      read_content(file) if file_exists?(file)
    end

    def read_rpmname_file
      file = rake.options.root.join 'RPMNAME'
      read_content(file) if file_exists?(file)
    end

    def domain_from_rpmname_file
      name.to_s.split(PREFIX).last
    end

    def read_maintainer_file ; end
    def read_readme_file     ; end
    def read_spec_file       ; end
    def read_changes_file    ; end

    def file_exists? file
      abort "File '#{file}' is mandatory, please update your code." +
            "\nAborting rake.." unless File.exists?(file)
      true
    end

    def read_content file
      content = File.read(file).strip
      abort "File '#{file}' must not be empty.\nAborting rake.." if content.size.zero?
      content
    end
  end
end
