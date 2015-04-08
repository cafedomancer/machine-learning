module Vector
  refine Array do
    def add(operand)
      zip(operand).map { |e1, e2| e1 + e2 }
    end

    def divide(operand)
      map { |e| e / operand }
    end

    def multiply(operand)
      map { |e| e * operand }
    end

    def subtract(operand)
      zip(operand).map { |e1, e2| e1 - e2 }
    end
  end
end
