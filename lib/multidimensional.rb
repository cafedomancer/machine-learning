module Multidimensional
  refine Array do
    def [](*indices)
      index = indices.shift
      if indices.empty?
        super(index)
      else
        super(index)[*indices]
      end
    end
  end
end
