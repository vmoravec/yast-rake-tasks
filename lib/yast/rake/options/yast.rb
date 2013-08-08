module Yast
  module Rake
    module Options
      module Yast
        INSTALL_DIR = '/usr/share/YaST2/'
        CLIENTS_DIR = INSTALL_DIR + 'clients/'
        MODULES_DIR = INSTALL_DIR + 'modules/'
        DESKTOP_DIR = '/usr/share/applications/YaST2/'
        DOC_DIR     = '/usr/share/doc/packages/'
        AUTOYAST_RNC_DIR = '/usr/share/YaST2/schema/autoyast/rnc/'

        def install_dir
          INSTALL_DIR
        end

        def desktop_dir
          DESKTOP_DIR
        end

        def doc_dir
          DOC_DIR
        end

        def rnc_install_dir
          RNC_INSTALL_DIR
        end

        def package_dir
          rake.options.root.join PACKAGE_DIR
        end

        def license_dir
          rake.options.root.join LICENCE_DIR
        end

        def tasks
          Tasks
        end
      end
    end
  end
end
