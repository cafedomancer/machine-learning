require_relative 'stats'

module Vector
  refine Array do
    using Stats

    def add(operand)
      zip(operand).map { |e1, e2| e1 + e2 }
    end

    def distance(other)
      subtract(other).norm
    end

    def divide(scalar)
      map { |e| e / scalar}
    end

    def multiply(scalar)
      map { |e| e * scalar }
    end

    def norm
      Math.sqrt(map { |e| e ** 2 }.sum)
    end

    def normalize
      divide(norm)
    end

    def subtract(operand)
      zip(operand).map { |e1, e2| e1 - e2 }
    end
  end
end
