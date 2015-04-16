require 'logistic_regression'

RSpec.describe LogisticRegression do
  describe '#fit' do
    it 'keeps the coefficients and intercept to its instance variables' do
      logit = LogisticRegression.new

      features =  Array.new(50) { Array.new(2) { rand(-2.0..2.0) } } +
                  Array.new(50) { Array.new(2) { rand(3.0..7.0) } }
      labels = Array.new(50, 0) +
               Array.new(50, 1)

      logit.fit(features, labels)

      expect(logit.instance_variable_get(:@coefficients)).not_to eq(0)
      expect(logit.instance_variable_get(:@intercept)).not_to eq(0)
    end
  end

  describe '#predict' do
    it 'returns the predicted probability' do
      logit = LogisticRegression.new

      features =  Array.new(50) { Array.new(2) { rand(-2.0..2.0) } } +
                  Array.new(50) { Array.new(2) { rand(3.0..7.0) } }
      labels = Array.new(50, 0) +
               Array.new(50, 1)

      logit.fit(features, labels)

      expect(logit.predict([[0.0, 0.0]]).first).to be < 0.5
    end
  end

  describe '#score' do
    it 'return the accuracy on the given features and labels' do
      logit = LogisticRegression.new

      features =  Array.new(50) { Array.new(2) { rand(-2.0..2.0) } } +
                  Array.new(50) { Array.new(2) { rand(3.0..7.0) } }
      labels = Array.new(50, 0) +
               Array.new(50, 1)

      logit.fit(features, labels)

      expect(logit.score([[0.0, 0.0], [5.0, 5.0]], [0, 0])).to eq(0.5)
    end
  end
end
