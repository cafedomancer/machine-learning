class NaiveBayes
  def fit(features, labels)
    @features = features
    @labels = labels
  end

  def predict(features)
    features.map { |feature|
      posteriors = @labels.uniq.sort.map { |label| posterior(feature, label) }
      @labels.uniq.sort.zip(posteriors).max_by { |label, posterior| posterior }.first
    }
  end

  def score(features, labels)
    predicted = predict(features)
    paired = labels.zip(predicted)
    compared = paired.map { |e1, e2| e1 == e2 }
    corrects = compared.count(true)
    corrects.fdiv(labels.length)
  end

  private

  def conditional_probability(feature_variable, label, logarithm = false)
    feature_variables = @features.zip(@labels).select { |_feature, _label| _label == label }.map { |feature, label| feature }.flatten

    occurrence = feature_variables.count(feature_variable) + 1
    total = feature_variables.length + @features.flatten.uniq.length
    probability = occurrence.fdiv(total)

    if logarithm
      Math.log(probability)
    else
      probability
    end
  end

  def likelihood(feature, label, logarithm = false)
    probabilities = feature.map { |feature_variable|
      conditional_probability(feature_variable, label, logarithm)
    }

    if logarithm
      probabilities.reduce(&:+)
    else
      probabilities.reduce(&:*)
    end
  end

  def prior(label, logarithm = false)
    occurrence = @labels.count(label)
    total = @labels.length
    probability = occurrence.fdiv(total)

    if logarithm
      Math.log(probability)
    else
      probability
    end
  end

  def posterior(feature, label, logarithm = false)
    if logarithm
      likelihood(feature, label, logarithm) + prior(label, logarithm)
    else
      likelihood(feature, label, logarithm) * prior(label, logarithm)
    end
  end
end
