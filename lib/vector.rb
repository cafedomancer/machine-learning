require_relative 'stats'

module Vector
  refine Array do
    using Stats

    def add(operand)
      zip(operand).map { |e1, e2| e1 + e2 }
    end

    def distance(other)
      self.subtract(other).norm
    end

    def divide(operand)
      map { |e| e / operand }
    end

    def multiply(operand)
      map { |e| e * operand }
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
