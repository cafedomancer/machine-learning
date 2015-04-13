require 'k_fold'

RSpec.describe KFold do
  describe '#each' do
    it 'returns the enumerator including train indices and test indices' do
      enumerator = KFold.new(9, 3).each

      expect(enumerator.next).to eq([[3, 4, 5, 6, 7, 8], [0, 1, 2]])
      expect(enumerator.next).to eq([[0, 1, 2, 6, 7, 8], [3, 4, 5]])
      expect(enumerator.next).to eq([[0, 1, 2, 3, 4, 5], [6, 7, 8]])
      expect { enumerator.next }.to raise_error(StopIteration)
    end

    it 'return the enumerator including shuffled train indices and shuffled test indices' do
      enumerator = KFold.new(9, 3, shuffle = true).each

      train, test = enumerator.next
      expect(train - test).to eq(train)
      train, test = enumerator.next
      expect(train - test).to eq(train)
      train, test = enumerator.next
      expect(train - test).to eq(train)
      expect { enumerator.next }.to raise_error(StopIteration)
    end
  end
end
