require 'yast/rake/config/base'
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
          @config = self
          @contexts = Hash.new
          register Base, false
          register Yast
          register Package
        end

        def register config_module, keep_module_namespace=true
          if keep_module_namespace
            config_name = get_downcased_module_name(config_module)
            remove_config_context(config_name)
            add_config_context(config_name, config_module)
          else
            config_module.public_instance_methods.each do |context_name|
              remove_config_context(context_name)
              add_base_config_context(context_name, config_module)
            end
          end
        end

        def update config_module
          config_name = get_downcased_module_name(config_module)
          if @contexts.member? config_name
            @contexts[config_name].extend(config_module)
          else
            add_new_config_context(config_name, config_module)
          end
        end

        def inspect
          @contexts.keys
        end

        private

        def remove_config_context config_name
          if respond_to? config_name
            self.class.__send__(remove_method, config_name)
            @contexts.delete config_name
          end
        end

        def add_config_context config_name, config_module
          new_context = Context.new(self,config_name).extend(config_module)
          @contexts[config_name] = new_context
          add_context_method(config_name)
        end

        def add_base_config_context context_name, config_module
          new_context = Context.new(self,context_name).extend(config_module)
          @contexts[context_name] = new_context
          add_base_context_method(context_name)
        end

        def add_context_method context_name
          define_singleton_method(context_name) { @contexts[context_name] }
        end

        def add_base_context_method context_name
          define_singleton_method(context_name) do
            @contexts[context_name].__send__(context_name)
          end
        end

        class Context
          attr_reader :config, :context_name, :errors

          def initialize config, context_name
            @errors = []
            @config = config
            @context_name = context_name
            @config_methods = []
            @errors_reported = false
          end

          def extend config_module
            @config_methods.concat(config_module.public_instance_methods)
            super
            setup if respond_to?(:setup)
            report_errors
            self
          end

          def inspect
            @config_methods.to_a
          end

          def report_errors force_report=false
            if force_report || !@errors_reported
              errors.each do |err_message|
                STDERR.puts("#{context_name.capitalize}: #{err_message}")
              end
            end
            @errors_reported = true
          end

          def abort
            Kernel.abort "Aborting rake due to #{errors.size} #{errors.one? ? 'error' : 'errors'}."
          end

          def rake
            config
          end

          def check
            report_errors true
          end

          def check!
            report_errors
            self.abort
          end

        end

        def get_downcased_module_name config_module
          config_module.to_s.split("::").last.downcase.to_sym
        end

      end

    end
  end
end

