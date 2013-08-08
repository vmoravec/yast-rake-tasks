require 'yast/rake/config/yast'
require 'yast/rake/config/package'
require 'yast/rake/config/obs'
require 'yast/rake/config/git'

module Yast
  module Rake
    module Config
      def self.load
        @config ||= Proxy.new # is it really a proxy?
        self
      end

      def self.config
        @config
      end

      class Proxy
        attr_reader :config

        def initialize
          @contexts = Hash.new
          register Yast
          register Package
        end

        def register config_module
          config_name = get_downcased_module_name(config_module)
          remove_config_context(config_name)
          add_new_config_context(config_name, config_module)
        end

        def update config_module
          config_name = get_downcased_module_name(config_module)
          if @contexts.member? config_name
            @contexts[config_name].extend(config_module)
          else
            add_new_config_context(config_name, config_module)
          end
        end

        def root
          rake_file_path, pwd = ::Rake.application.find_rakefile_location
          rake_file_path.slice!(/(#{::Rake::Application::DEFAULT_RAKEFILES.join('|')})?/)
          Pathname.new(pwd).join(rake_file_path).expand_path
        end

        def inspect
          Config
        end

        private

        def remove_config_context config_name
          if respond_to? config_name
            self.class.__send__(remove_method, config_name)
            @contexts.delete config_name
          end
        end

        def add_new_config_context config_name, config_module=nil
          if config_module
            new_context = Context.new(self).extend(config_module)
          else
            new_context = Context.new(self)
          end
          @contexts[config_name] = new_context
          define_singleton_method(config_name) { new_context }
        end

        class Context
          attr_reader :config

          def initialize config
            @config = config
            @config_methods = []
          end

          def extend config_module
            @config_methods.concat(config_module.public_instance_methods)
            super
            setup if respond_to?(:setup)
            self
          end

          def inspect
            @config_methods.to_a
          end

          def rake
            config
          end

        end

        def get_downcased_module_name config_module
          config_module.to_s.split("::").last.downcase
        end

      end

    end
  end
end

