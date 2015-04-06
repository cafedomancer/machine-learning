module Bidimensional
  refine Array do
    def [](*arguments)
      argument = arguments.shift

      if arguments.empty?
        super(argument)
      else
        super(argument)[*arguments]
      end
    end
  end
end
