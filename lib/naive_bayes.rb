require 'memoist'

class NaiveBayes
  extend Memoist

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

  def conditional_probability(feature_variable, label)
    feature_variables =
      @features.zip(@labels).select { |_feature, _label| _label == label }.map { |feature, label| feature }.flatten

    occurrence = feature_variables.count(feature_variable) + 1
    total = feature_variables.length + @features.flatten.uniq.length
    probability = occurrence.fdiv(total)

    Math.log(probability)
  end

  memoize :conditional_probability

  def likelihood(feature, label)
    conditional_probabilities = feature.map { |feature_variable|
      conditional_probability(feature_variable, label)
    }

    conditional_probabilities.reduce(&:+)
  end

  memoize :likelihood

  def prior(label)
    occurrence = @labels.count(label)
    total = @labels.length
    probability = occurrence.fdiv(total)

    Math.log(probability)
  end

  memoize :prior

  def posterior(feature, label)
    likelihood(feature, label) + prior(label)
  end

  memoize :posterior
end
