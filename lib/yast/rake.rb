module Yast
  module Rake
    module Paths
      YAST_INSTALL_DIR = '/usr/share/YaST2/'
      YAST_DESKTOP_DIR = '/usr/share/applications/YaST2/'
      RNC_DESTINATION  = '/usr/share/YaST2/schema/autoyast/rnc/'
    end

    def self.domain=(domain_name)
      @domain = domain_name
    end

    def self.domain
      @domain
    end
  end
end

require 'yast/rake/tasks'
