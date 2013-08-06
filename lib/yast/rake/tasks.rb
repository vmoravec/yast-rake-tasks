require 'yast/rake'

module Yast::Rake::Tasks
  version_file = File.expand_path('../../../../VERSION', __FILE__)
  VERSION = File.read(version_file).strip

  def self.import *tasks
    tasks
  end
end
