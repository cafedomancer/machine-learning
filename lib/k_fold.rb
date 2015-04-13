class KFold
  include Enumerable

  def initialize(n, k, shuffle = false)
    @n = n
    @k = k
    @shuffle = shuffle
  end

  def each(&block)
    return to_enum(:each) unless block_given?

    indices = (0...@n).to_a
    
    if @shuffle
      folds = indices.shuffle.each_slice(@n.fdiv(@k).ceil)
    else
      folds = indices.each_slice(@n.fdiv(@k).ceil)
    end

    folds.each do |fold|
      train = indices - fold
      test = fold
      yield train, test
    end
  end
end
