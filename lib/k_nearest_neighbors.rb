class KNearestNeighbors
  def initialize(n_neighbors = 5)
    @n_neighbors = n_neighbors
  end

  def fit(features, labels)
    @features = features
    @labels = labels
  end

  def predict(features)
    features.map do |f1|
      distances = @features.map do |f2|
        subtracted = f1.zip(f2).map { |e1, e2| e1 - e2 }
        norm = Math.sqrt(subtracted.map { |e| e ** 2 }.reduce(&:+))
      end

      labels = @labels.zip(distances).sort_by { |e| e.at(1) }.map { |e| e.at(0) }

      candidates = labels.take(@n_neighbors)
      candidates.max_by { |e| candidates.count(e) }
    end
  end

  #def score(features, labels)
  #end
end
