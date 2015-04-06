module Multidimensional
  refine Array do
    def [](*arguments)
      if flatten == self
        super(*arguments)
      else
        argument = arguments.shift

        if arguments.empty?
          super(argument)
        else
          super(argument)[*arguments]
        end
      end
    end
  end
end
