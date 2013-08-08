module Yast::Rake::Options
  module Git
    def git
      @git ||= GitDetails.new(self)
    end

    class GitDetails
      def initialize rake_scope
        @rake = rake_scope
      end

      def test
      end
    end

  end
end
