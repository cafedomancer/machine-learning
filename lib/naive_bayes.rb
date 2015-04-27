class NaiveBayes
  def fit(features, labels)
    @features = features.flatten.uniq.sort
    @labels = labels.uniq.sort

    @priors = @labels.reduce({}) { |priors, label|
      occurrence = labels.count(label)
      total = labels.length

      probability = occurrence.fdiv(total)
      # log_probability = Math.log(occurrence.fdiv(total))

      priors.update(label => probability)
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
          probability = occurrence.fdiv(total)
          # log_probability = Math.log(occurrence.fdiv(total))
        else
          probability = 0.0
          # log_probability = Math.log(0)
        end

        likelihood.update(label => probability)
      }

      likelihoods.update(feature => likelihood)
    }
  end

  def predict(features)
    features.map { |feature|
      feature = feature.uniq.sort
      feature = feature & @likelihoods.keys

      pp likelihoods = @labels.reduce({}) { |likelihoods, label|
        likelihood = feature.map { |feature|
          @likelihoods[feature][label]
        }

        likelihoods.update(label => likelihood.reduce(&:*))
      }

      pp posteriors = @labels.reduce({}) { |posteriors, label|
        posterior = @priors[label] * likelihoods[label]

        posteriors.update(label => posterior)
      }

      posteriors.max_by { |label, posterior| posterior }.first
    }
  end
end
