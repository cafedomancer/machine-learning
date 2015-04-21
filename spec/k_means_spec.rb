require 'k_means'

RSpec.describe KMeans do
  describe '#fit' do
    it do
      km = KMeans.new(n_clusters = 3)
      features = Array.new(50) { [rand(4.65351..5.35849), rand(0.1406144..0.3513856)] } +
                 Array.new(50) { [rand(5.419829..6.452171), rand(1.128247..1.523753)] } +
                 Array.new(50) { [rand(5.95212..7.22388), rand(1.75135..2.30065)] }
      require 'pp'
      pp km.fit(features)
    end
  end
end
