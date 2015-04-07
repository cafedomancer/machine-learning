require 'bidimensional'

using Bidimensional

RSpec.describe Bidimensional do
  describe '#[]' do
    it 'does not break super method' do
      expect([1, 2, 3][0]).to eq(1)
      expect([1, 2, 3][0, 1]).to eq([1])
      expect([1, 2, 3][0..1]).to eq([1, 2])
    end

    it 'returns the element in the first row and first column of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][0, 0]).to eq(1)
    end

    it 'returns the first row of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][0, nil]).to eq([1, 2, 3])
    end

    it 'returns the first and second rows of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][0..1, nil]).to eq([[1, 2, 3], [4, 5, 6]])
    end

    it 'returns the first column of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][nil, 0]).to eq([1, 4, 7])
    end

    it 'returns the first and second columns of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][nil, 0..1]).to eq([[1, 2], [4, 5], [7, 8]])
    end

    it 'returns itself' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][nil, nil]).to eq([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    end
  end

  describe '#consistent?' do
    it 'returns the result of checking its consistency' do
      expect([1, 2, 3].consistent?).to eq(false)
      expect([1, [2], 3].consistent?).to eq(false)
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]].consistent?).to eq(true)
    end
  end
end
