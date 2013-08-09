module Yast
  module Rake
    module Config
      module Base
        def root
          rake_file_path, pwd = ::Rake.application.find_rakefile_location
          rake_file_path.slice!(/(#{::Rake::Application::DEFAULT_RAKEFILES.join('|')})?/)
          Pathname.new(pwd).join(rake_file_path).expand_path
        end
      end
    end
  end
end
