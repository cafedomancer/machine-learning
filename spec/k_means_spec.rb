require 'k_means'

RSpec.describe KMeans do
  describe '#fit' do
    it 'returns the labeled features' do
      km = KMeans.new(n_clusters = 3)
      features = Array.new(50) { [rand(4.65351..5.35849), rand(0.1406144..0.3513856)] } +
                 Array.new(50) { [rand(5.419829..6.452171), rand(1.128247..1.523753)] } +
                 Array.new(50) { [rand(5.95212..7.22388), rand(1.75135..2.30065)] }
      expect(km.fit(features).map { |e| e.at(1) }).to include(0, 1, 2)
    end
  end
end
