class Vector
  include Enumerable
  include Math

  attr_reader :components

  def initialize(array)
    @components = array
  end

  def **(operand)
    components = @components.map { |component| component ** operand }
    self.class.new(components)
  end

  def -(operand)
    components = @components.map { |component| component - operand }
    self.class.new(components)
  end

  def ==(other)
    return false unless other.instance_of? self.class
    @components == other.components
  end

  def each(&block)
    return to_enum(:each) unless block_given?
    @components.each(&block)
    self
  end

  def length
    @components.length
  end

  def mean
    sum / length
  end

  def median
    sorted = @components.sort

    if length.even?
      index = length / 2 - 1
      sorted[index, 2].mean
    else
      index = length / 2
      sorted[index]
    end
  end

  def standard_deviation
    sqrt(variance)
  end

  def sum
    @components.reduce(0.0, &:+)
  end

  def variance
    m = mean
    ((self - m) ** 2).sum / (length - 1)
  end
end
