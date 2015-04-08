require 'stats'

using Stats

RSpec.describe Stats do
  describe '#mean' do
    it 'returns the mean of its elements' do
      expect([1.0, 2.0, 3.0].mean).to eq(2.0)
    end
  end

  describe '#median' do
    it 'returns the median of its elements' do
      expect([1.0, 2.0, 3.0].median).to eq(2.0)
    end
  end

  describe '#standard_deviation' do
    it 'returns the standard deviation of its elements' do
      expect([1.0, 2.0, 3.0].standard_deviation).to eq(1.0)
    end
  end

  describe '#sum' do
    it 'returns the sum of its elements' do
      expect([1.0, 2.0, 3.0].sum).to eq(6.0)
    end
  end

  describe '#variance' do
    it 'returns the variance of its elements' do
      expect([1.0, 2.0, 3.0].variance).to eq(1.0)
    end
  end
end
