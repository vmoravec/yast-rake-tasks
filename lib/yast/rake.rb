module Yast
  module Rake
    def self.domain=(domain_name)
      @domain = domain_name
    end

    def self.domain
      @domain
    end
  end
end
