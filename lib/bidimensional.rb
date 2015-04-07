module Bidimensional
  refine Array do
    def [](*arguments)
      if consistent?
        if arguments.length != 2
          raise ArgumentError, "wrong number of arguments (#{arguments.length} for 2)"
        end

        row, column = arguments

        if !row.nil? && !column.nil?
          at(row).at(column)
        elsif !row.nil?
          super(row)
        elsif !column.nil?
          map { |e| e[column] }
        else
          clone
        end
      else
        super(*arguments)
      end
    end

    def consistent?
      # it does not consider the case of 3 or higher dimensional
      if all? { |e| e.instance_of?(Array) }
        map(&:length).uniq.one?
      else
        false
      end
    end
  end
end
