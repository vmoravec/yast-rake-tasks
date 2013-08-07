module Yast::Rake::Options
  module Package

    def package
      @package ||= Attributes.new self # self is needed for accessing other rake configs
    end

    class Attributes

      attr_reader :version, :name, :maintainer

      def initialize rake_scope
        @rake    = rake_scope
        @version = read_version_file
        @name    = read_rpmname_file
      end

      private

      def read_version_file
        file = @rake.root.join 'VERSION'
        read_content(file) if file_exists?(file)
      end

      def read_rpmname_file
        file = @rake.root.join 'RPMNAME'
        read_content(file) if file_exists?(file)
      end

      def read_maintainer_file ; end
      def read_readme_file     ; end
      def read_spec_file       ; end
      def read_changes_file    ; end

      def file_exists? file
        abort "File '#{file}' is mandatory, please update your code." +
              "\nAborting rake.." unless File.exists? file
        true
      end

      def read_content file
        content = File.read(file).strip
        abort "File '#{file}' must not be empty.\nAborting rake.." if content.size.zero?
        content
      end
    end
  end
end
