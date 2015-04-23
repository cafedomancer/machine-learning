require 'naive_bayes'

RSpec.describe NaiveBayes do
  describe '#fit' do
    it 'keeps feature variables and probablities matrix to instance variables' do
      nb = NaiveBayes.new

      features = [['human', 'interface', 'computer'],
                  ['survey', 'user', 'computer', 'system', 'response', 'time'],
                  ['eps', 'user', 'interface', 'system'],
                  ['system', 'human', 'system', 'eps'],
                  ['user', 'response', 'time'],
                  ['trees'],
                  ['graph', 'trees'],
                  ['graph', 'minors', 'trees'],
                  ['graph', 'minors', 'survey']]
      labels = [1, 1, 1, 1, 1, 1, 1, 1, 1]

      nb.fit(features, labels)

      expect(nb.instance_variable_defined?('@variables')).to be_truthy
      expect(nb.instance_variable_defined?('@probabilities')).to be_truthy
    end
  end

  describe '#predict' do
    it 'return the logarithmic probability that the passed features will be classified into the training dataset label (temporary impl)' do
      nb = NaiveBayes.new

      features = [['human', 'interface', 'computer'],
                  ['eps', 'user', 'interface', 'system'],
                  ['system', 'human', 'system', 'eps'],
                  ['user', 'response', 'time'],
                  ['trees'],
                  ['graph', 'trees'],
                  ['graph', 'minors', 'trees'],
                  ['graph', 'minors', 'survey']]
      labels = [1, 1, 1, 1, 1, 1, 1, 1]

      nb.fit(features, labels)

      expect(nb.predict([['survey', 'user', 'computer', 'system', 'response', 'time']]).first).to be_instance_of(Float)
    end
  end
end

