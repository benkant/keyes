module Keyes

  # TODO placeholder for some helpers
  module Scorers
    def self.included(base)
      base.extend ClassMethods
      base.extend HelperMethods
    end

    module HelperMethods
    end

    module ClassMethods
    end
  end
end

Dir[File.dirname(__FILE__) + '/scorers/*.rb'].sort.each do |path|
  filename = File.basename(path)
  require "keyes/scorers/#{filename}"
end
