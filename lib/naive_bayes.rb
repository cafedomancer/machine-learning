class NaiveBayes
  def fit(features, labels)
    @documents = features
    @terms = @documents.flatten.uniq.sort
    @term_document_matrix = @terms.map { |term|
      @documents.map { |document| document.count(term) }
    }
  end

  def predict(features)
    documents = features

    documents.map { |document|
      terms = document.uniq.sort
      intersection = @terms & terms

      probablities = @term_document_matrix.map { |row|
        row.count { |frequency| frequency != 0}.fdiv(@documents.length)
      }

      likelihood = intersection.map { |term|
        probablities.at(@terms.find_index(term))
      }.reduce(&:*) * 1e-6 ** (@terms.length - intersection.length)

      prior = 0.5

      likelihood * prior
    }
  end
end
