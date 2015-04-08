module Stats
  refine Array do
    def mean
      sum / length
    end

    def median
      sorted = sort

      if length.even?
        index = length / 2 - 1
        sorted[index, 2].mean
      else
        index = length / 2
        sorted[index]
      end
    end

    def standard_deviation
      Math.sqrt(variance)
    end

    def sum
      reduce(0.0, &:+)
    end

    def variance
      m = mean
      map { |e| (e - m) ** 2 }.sum / (length - 1)
    end
  end
end
