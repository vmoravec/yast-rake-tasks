lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'yast/rake'

module Hello

  def setup
    @test = 'test'
  end

  attr_accessor :test


end

rake.config.register Hello, false
