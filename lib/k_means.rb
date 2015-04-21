require 'pp'

require_relative 'stats'
require_relative 'vector'

using Stats
using Vector

class KMeans
  def initialize(n_clusters = 8)
    @n_clusters = n_clusters
  end

  # refer to http://ja.wikipedia.org/wiki/K%E5%B9%B3%E5%9D%87%E6%B3%95
  def fit(features)
    # the features vectors are labeled randomly
    paired = features.map { |feature|
      [feature, rand(0...@n_clusters)]
    }

    # assignment step is repeated 5 times (hard-coded)
    # but the interruption of assignment loop should be based on centroids' convergence
    5.times do
      grouped = paired.group_by { |e| e.at(1) }

      # the centroids are calculated by the mean of each group
      centroids_paired = grouped.map { |label, paired|
        features = paired.map { |e| e.at(0) }
        # for 2 dimensional array
        centroid = [features.map { |e| e.at(0) }.mean, features.map { |e| e.at(1) }.mean]
        [centroid, label]
      }

      # the features vectors are relabeld by the nearest centroid label
      paired = paired.map { |feature, _|
        distances_paired = centroids_paired.map { |centroid, label|
          [feature.distance(centroid), label]
        }
        distances_paired = distances_paired.sort_by { |e| e.at(0) }
        label = distances_paired.at(0).at(1)
        [feature, label]
      }
    end

    paired
  end
end
