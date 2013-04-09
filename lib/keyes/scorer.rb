require 'yaml'

module Keyes

  class Scorer
    def initialize
      load_data
    end

    def score(params)
      raise NotImplementedError,
        "Subclasses must implement a score(params) method."
    end

    def kind
      self.class.kind
    end

    def self.kind
      @kind ||= begin
        full_name = name.split(/::/).last
        full_name = full_name.gsub(/([a-z\d])([A-Z])/,'\1_\2').downcase
        full_name.sub(/_scorer$/, '').to_sym
      end
    end

    protected
    def data
      @data || {}
    end

    private
    def load_data
      @data = YAML::load(IO.read(data_file)) if File.exists?(data_file)
    end

    def data_file
      data_directory + '/' + kind.to_s + '.yaml'
    end

    def data_directory
      File.dirname(__FILE__) + '/../../data/scorers'
    end
  end
end
