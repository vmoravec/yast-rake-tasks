module Yast
  module Rake
    module Options
      module Base
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
          rake_file_path.slice!(/(#{::Rake::Application::DEFAULT_RAKEFILES.join('|')})?/)
          Pathname.new(pwd).join(rake_file_path).expand_path
        end

        def tasks
          Tasks
        end
      end
    end
  end
end
