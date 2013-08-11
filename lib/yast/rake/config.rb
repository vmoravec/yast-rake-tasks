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

      def self.method_missing name, *args, &block
        super
      rescue => e
        puts "rake.config does not know '#{name}'"
        puts e.message
        puts e.backtrace.first
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
          if @contexts.member?(config_name)
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
          new_context = Context.new(config_name, self).extend(config_module)
          @contexts[config_name] = new_context
          add_context_method(config_name)
          @contexts[config_name]
        end

        SETUP_METHOD = :setup

        def add_base_config_context context_name, config_module
          return if context_name == SETUP_METHOD
          new_context = Context.new(context_name, self).extend(config_module)
          @contexts[context_name] = new_context
          add_base_context_method(context_name)
        end

        def add_context_method context_name
          define_singleton_method(context_name) { @contexts[context_name] }
          @contexts[context_name]
        end

        #TODO add arity when sending the method call
        #     currently are supported only methods without args
        def add_base_context_method context_name
          define_singleton_method(context_name) do
            @contexts[context_name].__send__(context_name)
          end
          @contexts[context_name]
        end

        def method_missing name, *args, &block
          super
        rescue => e
          puts "rake.config.#{name} does not know '#{name}'"
          puts "Registered contexts: #{@contexts.keys.join ', '}"
          puts e.backtrace.first
        end

        class Context
          attr_reader :config, :context_name, :errors

          def initialize context_name, config
            @errors = []
            @config = config
            @context_name = context_name
            @config_methods = []
            @errors_reported = false
          end

          def extend config_module
            make_setup_method_private(config_module)
            @extended_methods = config_module.public_instance_methods
            @config_methods.concat(@extended_methods)
            super                         # keep the Object.extend functionality
            run_setup
            report_errors                 # if setup collected errors, show them now
            self                          # return the extended context
          end

          def inspect
            @extended_methods.to_a
          end

          def report_errors force_report=false
            if force_report || !@errors_reported
              errors.each do |err_message|
                STDERR.puts("#{context_name.capitalize}: #{err_message}")
              end
            end
            @errors_reported = true
          end

          def rake
            config
          end

          def check
            report_errors
          end

          def check!
            report_errors
            Kernel.abort "Found #{errors.size} #{errors.one? ? 'error' : 'errors'}."
          end

          private

          def make_setup_method_private config_module
            if config_module.public_instance_methods.include?(SETUP_METHOD)
              config_module.__send__(:private, SETUP_METHOD)
            end
          end

          def run_setup
            __send__(SETUP_METHOD) if respond_to?(SETUP_METHOD, true)  # call the setup method from config module
          end

          def method_missing name, *args, &block
            super
          rescue => e
            puts "rake.config.#{context_name} does not know '#{name}'"
            puts e.backtrace.first
          end

        end

        def get_downcased_module_name config_module
          config_module.to_s.split("::").last.downcase.to_sym
        end

      end

    end
  end
end

