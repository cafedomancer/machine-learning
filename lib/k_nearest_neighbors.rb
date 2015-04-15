class KNearestNeighbors
  def initialize(n_neighbors = 5)
    @n_neighbors = n_neighbors
  end

  def fit(features, labels)
    @features = features
    @labels = labels
  end

  def predict(features)
    features.map { |f1|
      distances = @features.map { |f2|
        subtracted = f1.zip(f2).map { |e1, e2| e1 - e2 }
        squared = subtracted.map { |e| e ** 2 }
        Math.sqrt(squared.reduce(&:+))
      }

      paired = @labels.zip(distances)
      paired = paired.sort_by { |e| e.at(1) }

      labels = paired.map { |e| e.at(0) }

      candidates = labels.take(@n_neighbors)
      candidates.max_by { |e| candidates.count(e) }
    }
  end

  def score(features, labels)
    predicted = predict(features)
    paired = labels.zip(predicted)
    compared  = paired.map { |e1, e2| e1 == e2 }
    corrects = compared.count(true)
    corrects.fdiv(labels.length)
  end
end
