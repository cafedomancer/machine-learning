class LogisticRegression
  def fit(features, labels)
    @coefficients = Array.new(2, 0)
    @intercept = 0
    learning_rate = 0.13

    # the number of loop steps need to be determined
    # the learning rate need to be scheduled appropriately
    features.zip(labels).each do |feature, label|
      predicted = predict([feature]).first
      error = label - predicted

      gradient_coefficients = -1 * feature.map { |e| e * error }.reduce(&:+)
      gradient_intercept = -1 * error

      @coefficients = @coefficients.map { |e| e - learning_rate * gradient_coefficients }
      @intercept = @intercept - learning_rate * gradient_intercept
    end
  end

  def predict(features)
    features.map { |f|
      sigmoid(@coefficients.zip(f).map { |w, e| w * e }.reduce(&:+) + @intercept)
    }
  end

  def score(features, labels)
    raise NotImplementedError
  end

  private

  def sigmoid(exponent)
    1.fdiv(1 + Math.exp(-1 * exponent))
  end
end
