class LogisticRegression
  def fit(features, labels)
    ws = Array.new(2, 0)
    b = 0
    eta = 0.1

    features.zip(labels).each do |feature, label|
      predicted = sigmoid(ws.zip(feature).map { |w, e| w * e }.reduce(&:+) + b)
      error = label - predicted

      gradient_ws = -1 * feature.map { |e| e * error }.reduce(&:+).fdiv(feature.length)
      gradient_b = -1 * error

      ws = ws.map { |w| w  - eta * gradient_ws }
      b = b - eta * gradient_b
    end

    @coefficients = ws
    @intercept = b
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
