require 'yast/rake/options/base'
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
        include Base
        include Package
        include Git
        include Obs
      end
    end
  end
end

