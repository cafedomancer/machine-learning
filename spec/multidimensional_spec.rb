require 'multidimensional'

using Multidimensional

RSpec.describe Multidimensional do
  describe '#[]' do
    it 'does not break super method' do
      expect([1, 2, 3][0]).to eq(1)
      expect([1, 2, 3][0, 2]).to eq([1, 2])
      expect([1, 2, 3][0..1]).to eq([1, 2])
    end

    it 'returns the element in the first row and first column of its elements' do
      expect([[1, 2, 3], [4, 5, 6]][0, 0]).to eq(1)
    end
  end
end
