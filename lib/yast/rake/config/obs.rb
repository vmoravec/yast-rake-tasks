module Yast::Rake::Options
  module Obs
    def obs
      @obs ||= Options.new
    end

    class Options
      def url
      end

      def target
      end
    end
  end
end
