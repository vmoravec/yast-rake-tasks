module Yast::Rake
  module Obs
    def obs
      @obs ||= Attributes.new
    end

    class Attributes
      def url
      end

      def target
      end
    end
  end
end
