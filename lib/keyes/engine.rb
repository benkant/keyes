module Keyes
  class Engine
    class MissingParam < Exception; end;

    REQUIRED_PARAMS = [:ip_address, :city, :region, :postal, :country]

    def initialize
      # register scorers
      # TODO: can this just be some magic based on
      # classes in Keyes::Scorers ?
      @scorers = [
        Scorers::IpAddressScorer.new,
        Scorers::CountryScorer.new
      ]
    end

    def score(params)
      check_params(params)
      results = scorers.map do |scorer|
        scorer.score(params)
      end

      # return the highest score
      results.max
    end

    private
    def check_params(params)
      REQUIRED_PARAMS.each do |param|
        raise MissingParam if params[param].nil?
      end
    end

    def scorers
      @scorers
    end
  end
end
