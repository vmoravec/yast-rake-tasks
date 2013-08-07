require 'yast/rake/options/base'
require 'yast/rake/options/package'
require 'yast/rake/options/obs'
require 'yast/rake/options/git'

module Yast
  module Rake
    module Options
      def self.get
        @options ||= OptionsProxy.new
      end

      class OptionsProxy
        include Base
        include Package
        include Git
        include Obs

        def options
          self
        end
      end
    end
  end
end

