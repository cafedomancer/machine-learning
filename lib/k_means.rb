require 'pp'

require_relative 'stats'
require_relative 'vector'

using Stats
using Vector

class KMeans
  def initialize(n_clusters = 8)
    @n_clusters = n_clusters
  end

  def fit(features)
    features = features.map { |feature|
      [feature, rand(0...@n_clusters)]
    }

    previous_features = nil

    until previous_features == features
      grouped = features.group_by { |e| e.at(1) }

      centroids = grouped.map { |label, features|
        features = features.map { |e| e.at(0) }
        centroid = features.first.length.times.map { |i|
          features.map { |e| e.at(i) }.mean
        }
        [centroid, label]
      }

      features = features.map { |feature, _|
        distances = centroids.map { |centroid, label|
          [feature.distance(centroid), label]
        }
        distances = distances.sort_by { |e| e.at(0) }
        label = distances.at(0).at(1)
        [feature, label]
      }

      previous_features = features
    end

    features
  end
end
