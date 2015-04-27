class NaiveBayes
  def fit(features, labels)
    @features = features.flatten.uniq.sort
    @labels = labels.uniq.sort

    @priors = @labels.reduce({}) { |priors, label|
      occurrence = labels.count(label)
      total = labels.length

      log_probability = Math.log(occurrence.fdiv(total))

      priors.update(label => log_probability)
    }

    @likelihoods = @features.reduce({}) { |likelihoods, feature|
      likelihood = @labels.reduce({}) { |likelihood, label|
        paired = features.zip(labels)
        selected = paired.select { |_, original_label|
          original_label == label
        }

        occurrence = selected.map { |original_feature, _|
          original_feature.include?(feature)
        }.count(true)
        total = selected.length

        unless occurrence.zero?
          log_probability = Math.log(occurrence.fdiv(total))
        else
          log_probability = Math.log(1e-6)
        end

        likelihood.update(label => log_probability)
      }

      likelihoods.update(feature => likelihood)
    }
  end

  def predict(features)
    features.map { |feature|
      provided_feature = feature.uniq.sort

      likelihoods = @labels.reduce({}) { |likelihoods, label|
        likelihood = @likelihoods.map { |feature, _|
          if provided_feature.include?(feature)
            @likelihoods[feature][label]
          else
            Math.log(1e-6)
          end
        }.reduce(&:+)

        likelihoods.update(label => likelihood)
      }

      posteriors = @labels.reduce({}) { |posteriors, label|
        posterior = @priors[label] + likelihoods[label]

        posteriors.update(label => posterior)
      }

      posteriors.max_by { |label, posterior| posterior }.first
    }
  end

  def score(features, labels)
    predicted = predict(features)
    paired = labels.zip(predicted)
    compared = paired.map { |e1, e2| e1 == e2 }
    corrects = compared.count(true)
    corrects.fdiv(labels.length)
  end
end
