class NaiveBayes
  def fit(features, labels)
    @variables = features.flatten.uniq.sort

    matrix = @variables.map { |variable|
      features.map { |feature| feature.include?(variable) }
    }

    @probabilities = matrix.map { |row|
      Math.log(row.count(true).fdiv(features.length))
    }
  end

  def predict(features)
    features.map { |feature|
      variables = feature.uniq.sort
      intersection = @variables & variables

      epsilon = Math.log(1e-6)

      probabilities = @probabilities.zip(@variables).map { |probability, variable|
        if intersection.include?(variable)
          probability
        else
          epsilon
        end
      }

      prior = Math.log(0.5)
      likelihood = probabilities.reduce(&:+)

      prior + likelihood
    }
  end
end
