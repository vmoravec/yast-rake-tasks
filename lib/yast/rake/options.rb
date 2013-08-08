require 'yast/rake/options/yast'
require 'yast/rake/options/package'
require 'yast/rake/options/obs'
require 'yast/rake/options/git'

module Yast
  module Rake
    module Options
      def self.options
        @options ||= Proxy.new
      end

      class Proxy
        def initialize
          register Yast
          register Package
        end

        #TODO fix the endless loop here..
        def register extension_module
          extension_name = parse_module_namespace(extension_module)
          @extensions ||= {}
          abort "Extension must be a ruby module." unless extension_module.is_a?(Module)
          if @extensions.keys.include? extension_name
            abort "rake.options.#{extension_name} already defined."
          end
          @extensions[extension_name] = extension_module
          extension_attributes = Options.const_set("#{extension_name.capitalize}Attributes", Attributes)
          puts extension_attributes
          puts extension_attributes.new
          extension_attributes.new.extend extension_module
          define_singleton_method(extension_name) { extension_attributes }
        end

        def update extension_module
          extension_name = parse_module_namespace(extension_module)
          if self.respond_to?(extension_name.to_sym)
            __send__(extension_name.to_sym.extend(extension_module))
          else
            register extension_module
          end
        end

        def parse_module_namespace extension_module
          extension_module.to_s.split("::").last.downcase
        end

        def root
          rake_file_path, pwd = ::Rake.application.find_rakefile_location
          rake_file_path.slice!(/(#{::Rake::Application::DEFAULT_RAKEFILES.join('|')})?/)
          Pathname.new(pwd).join(rake_file_path).expand_path
        end

        def options
          self
        end

        class Attributes
          include Rake

          def inspect
            public_methods(false)
          end

        end

        def [] option_name
          if self.respond_to?(option_name)
            self.send option_name
          else
            nil
          end
        end

        def inspect
          attributes
        end

        def attributes
          @attributes ||= []
        end

      end

    end
  end
end

