module Bidimensional
  refine Array do
    def [](*arguments)
      if consistent?
        if arguments.length != 2
          raise ArgumentError, "wrong number of arguments (#{arguments.length} for 2)"
        end

        row, column = arguments

        case row
        when Integer
          case column
          when Integer
            at(row).at(column)
          when Range
            at(row).slice(column)
          when NilClass
            at(row)
          else
            raise TypeError, "no implicit conversion from #{column.class} to Integer, Range or NilClass"
          end
        when Range
          case column
          when Integer
            slice(row).map { |e| e.at(column) }
          when Range
            slice(row).map { |e| e.slice(column) }
          when NilClass
            slice(row)
          else
            raise TypeError, "no implicit conversion from #{column.class} to Integer, Range or NilClass"
          end
        when NilClass
          case column
          when Integer
            map { |e| e.slice(column) }
          when Range
            map { |e| e.slice(column) }
          when NilClass
            clone
          else
            raise TypeError, "no implicit conversion from #{column.class} to Integer, Range or NilClass"
          end
        else
          raise TypeError, "no implicit conversion from #{row.class} to Integer, Range or NilClass"
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
