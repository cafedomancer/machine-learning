module Matrix
  refine Array do
    def [](*arguments)
      if matrix?
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
          when Array
            at(row).values_at(*column)
          when NilClass
            at(row)
          else
            raise TypeError, "no implicit conversion from #{column.class} to Integer, Range, Array or NilClass"
          end
        when Range
          case column
          when Integer
            slice(row).map { |e| e.at(column) }
          when Range
            slice(row).map { |e| e.slice(column) }
          when Array
            slice(row).map { |e| e.values_at(*column) }
          when NilClass
            slice(row)
          else
            raise TypeError, "no implicit conversion from #{column.class} to Integer, Range, Array or NilClass"
          end
        when Array
          case column
          when Integer
            values_at(*row).map { |e| e.at(column) }
          when Range
            values_at(*row).map { |e| e.slice(column) }
          when Array
            values_at(*row).map { |e| e.values_at(*column) }
          when NilClass
            values_at(*row)
          else
            raise TypeError, "no implicit conversion from #{column.class} to Integer, Range, Array or NilClass"
          end
        when NilClass
          case column
          when Integer
            map { |e| e.at(column) }
          when Range
            map { |e| e.slice(column) }
          when Array
            map { |e| e.values_at(*column) }
          when NilClass
            clone
          else
            raise TypeError, "no implicit conversion from #{column.class} to Integer, Range, Array or NilClass"
          end
        else
          raise TypeError, "no implicit conversion from #{row.class} to Integer, Range, Array or NilClass"
        end
      else
        super(*arguments)
      end
    end

    def matrix?
      # it does not consider the case of 3 or higher dimensional
      if all? { |e| e.instance_of?(Array) }
        map(&:length).uniq.one?
      else
        false
      end
    end
  end
end
