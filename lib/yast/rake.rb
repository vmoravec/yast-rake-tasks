require 'yast/rake/package'
require 'yast/rake/obs'
require 'yast/rake/git'
require 'pathname'

module Yast
  module Rake
    module Defaults
      YAST_INSTALL_DIR = '/usr/share/YaST2/'
      YAST_DESKTOP_DIR = '/usr/share/applications/YaST2/'
      RNC_INSTALL_DIR  = '/usr/share/YaST2/schema/autoyast/rnc/'

      def yast_install_dir
        YAST_INSTALL_DIR
      end

      def yast_desktop_dir
        YAST_DESKTOP_DIR
      end

      def rnc_install_dir
        RNC_INSTALL_DIR
      end

      def root
        rake_file_path, pwd = ::Rake.application.find_rakefile_location
        rake_file_path.slice! 'Rakefile'
        Pathname.new(pwd).join(rake_file_path).expand_path
      end

      def tasks
        Tasks
      end
    end

    def rake
      @rake ||= Config.new
    end

    class Config
      include Defaults
      include Package
      include Obs
      include Git
    end

  end
end

self.extend Yast::Rake

require 'yast/rake/tasks'

Yast::Rake::Tasks.import
