require 'k_nearest_neighbors'

RSpec.describe KNearestNeighbors do
  describe '#fit' do
    it 'keeps the input arguments to its instance variables' do
      knn = KNearestNeighbors.new(n_neighbors = 3)

      features =  [[0], [1], [2], [3]]
      labels = [0, 0, 1, 1]

      knn.fit(features, labels)
      expect(knn.instance_variable_get(:@features)).to eq(features)
      expect(knn.instance_variable_get(:@labels)).to eq(labels)
    end
  end

  describe '#predict' do
    it 'returns the predicted label' do
      knn = KNearestNeighbors.new(n_neighbors = 3)

      features =  [[0], [1], [2], [3]]
      labels = [0, 0, 1, 1]

      knn.fit(features, labels)
      expect(knn.predict([[1.1]])).to eq([0])
    end
  end

  describe '#score' do
    it 'return the accuracy on the given features and labels' do
      knn = KNearestNeighbors.new(n_neighbors = 3)

      features = [[0], [1], [2], [3]]
      labels = [0, 0, 1, 1]

      knn.fit(features, labels)
      expect(knn.score([[1.1], [1.5]], [0, 1])).to eq(0.5)
    end
  end
end
