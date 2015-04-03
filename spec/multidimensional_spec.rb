require 'multidimensional'

using Multidimensional

RSpec.describe Multidimensional do
  describe '#[]' do
    it 'does not break super method' do
      expect([1, 2, 3][0]).to eq(1)
    end

    it 'returns the element in the first row and first column of its elements' do
      expect([[1, 2, 3], [4, 5, 6]][0, 0]).to eq(1)
    end
  end
end
