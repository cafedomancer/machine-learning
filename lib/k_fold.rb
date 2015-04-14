class KFold
  include Enumerable

  def initialize(n, k, shuffle = false)
    @n = n
    @k = k
    @shuffle = shuffle
  end

  def each(&block)
    return to_enum(:each) unless block_given?

    folds.each do |fold|
      train = indices - fold
      test = fold
      yield train, test
    end
  end

  private

  def indices
    (0...@n).to_a
  end

  def folds
    if @shuffle
      indices.shuffle.each_slice(@n.fdiv(@k).ceil)
    else
      indices.each_slice(@n.fdiv(@k).ceil)
    end
  end
end
