require 'matrix'

using Matrix

RSpec.describe Matrix do
  describe '#[]' do
    it 'does not break super method' do
      expect([1, 2, 3][0]).to eq(1)
      expect([1, 2, 3][0, 1]).to eq([1])
      expect([1, 2, 3][0..1]).to eq([1, 2])
    end

    it 'returns the element in the first row and first column of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][0, 0]).to eq(1)
    end

    it 'returns the elements in the first row and first and second columns of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][0, 0..1]).to eq([1, 2])
    end

    it 'returns the elements in the first row and first and third columns of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][0, [0, 2]]).to eq([1, 3])
    end

    it 'returns the first row of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][0, nil]).to eq([1, 2, 3])
    end

    it 'returns the elements in the first and second rows and first column of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][0..1, 0]).to eq([1, 4])
    end

    it 'returns the elements in the first and second rows and first and second columns of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][0..1, 0..1]).to eq([[1, 2], [4, 5]])
    end

    it 'returns the elements in the first and second rows and first and third columns of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][0..1, [0, 2]]).to eq([[1, 3], [4, 6]])
    end

    it 'returns the first and second rows of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][0..1, nil]).to eq([[1, 2, 3], [4, 5, 6]])
    end

    it 'returns the elements in the first and third rows and first column of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][[0, 2], 0]).to eq([1, 7])
    end

    it 'returns the elements in the first and third rows and first and second columns of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][[0, 2], 0..1]).to eq([[1, 2], [7, 8]])
    end

    it 'returns the elements in the first and third rows and first and third columns of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][[0, 2], [0, 2]]).to eq([[1, 3], [7, 9]])
    end

    it 'returns the first and third rows of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][[0, 2], nil]).to eq([[1, 2, 3], [7, 8, 9]])
    end

    it 'returns the first column of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][nil, 0]).to eq([1, 4, 7])
    end

    it 'returns the first and second columns of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][nil, 0..1]).to eq([[1, 2], [4, 5], [7, 8]])
    end

    it 'returns the first and third columns of its elements' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][nil, [0, 2]]).to eq([[1, 3], [4, 6], [7, 9]])
    end

    it 'returns itself' do
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]][nil, nil]).to eq([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    end

    it 'raises type error if the arguments are integer, range nor nil' do
      expect { [[1, 2, 3], [4, 5, 6], [7, 8, 9]]['hoge', nil] }.to raise_error(TypeError)
      expect { [[1, 2, 3], [4, 5, 6], [7, 8, 9]][nil, 'fuga'] }.to raise_error(TypeError)
      expect { [[1, 2, 3], [4, 5, 6], [7, 8, 9]]['hoge', 'fuga'] }.to raise_error(TypeError)
    end
  end

  describe '#matrix?' do
    it 'returns the result of checking if itself is a matrix' do
      expect([1, 2, 3].matrix?).to eq(false)
      expect([1, [2], 3].matrix?).to eq(false)
      expect([[1, 2, 3], [4, 5, 6], [7, 8, 9]].matrix?).to eq(true)
    end
  end
end
