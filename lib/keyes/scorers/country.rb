module Keyes
  module Scorers

    class CountryScorer < Scorer
      def score(params)
        if params[:country].downcase == 'ng'
          80
        end
      end
    end

  end
end
