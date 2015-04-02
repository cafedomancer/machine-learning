require 'vector'

RSpec.describe Vector do
  describe '#**' do
    it 'return a new vector of the results of power' do
      vector = Vector.new([1.0, 2.0, 3.0])

      expect(vector ** 2.0).to eq(Vector.new([1.0, 4.0, 9.0]))
    end
  end

  describe '#-' do
    it 'return a new vector of the results of subtraction' do
      vector = Vector.new([1.0, 2.0, 3.0])

      expect(vector - 2.0).to eq(Vector.new([-1.0, 0.0, 1.0]))
    end
  end

  describe '#==' do
    it 'returns the result of comprasion' do
      vector = Vector.new([1.0, 2.0, 3.0])

      expect(vector == Vector.new([1.0, 2.0, 3.0])).to eq(true)
      expect(vector == Vector.new([-1.0, 0.0, 1.0])).to eq(false)
      expect(vector == [1.0, 2.0, 3.0]).to eq(false)
    end
  end

  describe '#each' do
    it 'returns the enumerator of components' do
      vector = Vector.new([1.0, 2.0, 3.0])
      enumerator = vector.each

      expect(enumerator.next).to eq(1.0)
      expect(enumerator.next).to eq(2.0)
      expect(enumerator.next).to eq(3.0)
      expect { enumerator.next }.to raise_error(StopIteration)
    end
  end

  describe '#length' do
    it 'returns the length of components' do
      vector = Vector.new([1.0, 2.0, 3.0])

      expect(vector.length).to eq(3.0)
    end
  end

  describe '#mean' do
    it 'returns the mean of components' do
      vector = Vector.new([1.0, 2.0, 3.0])

      expect(vector.mean).to eq(2.0)
    end
  end

  describe '#median' do
    it 'returns the median of components' do
      vector = Vector.new([1.0, 2.0, 3.0])

      expect(vector.median).to eq(2.0)
    end
  end

  describe '#standard_deviation' do
    it 'returns the standard deviation of components' do
      vector = Vector.new([1.0, 2.0, 3.0])

      expect(vector.variance).to eq(1.0)
    end
  end

  describe '#sum' do
    it 'returns the sum of components' do
      vector = Vector.new([1.0, 2.0, 3.0])

      expect(vector.sum).to eq(6.0)
    end
  end

  describe '#variance' do
    it 'returns the variance of components' do
      vector = Vector.new([1.0, 2.0, 3.0])

      expect(vector.variance).to eq(1.0)
    end
  end
end
