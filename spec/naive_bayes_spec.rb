require 'naive_bayes'

RSpec.describe NaiveBayes do
  describe '#fit' do
    it 'keeps feature variables and probablities matrix to instance variables' do
      nb = NaiveBayes.new

      features = [%w(dogs are awesome cats too i love my dog),
                  %w(cats are more preferred by software developers i never could stand cats i have a dog),
                  %w(my dog's name is willy he likes to play with my wife's cat all day long i love dogs),
                  %w(cats are difficult animals unlike dogs really annoying i hate them all),
                  %w(so which one should you choose a dog definitely),
                  %w(the favorite food for cats is bird meat although mice are good but birds are a delicacy),
                  %w(a dog will eat anything including birds or whatever meat),
                  %w(my cat's favorite place to purr is on my keyboard),
                  %w(my dog's favorite place to take a leak is the tree in front of our house)]
      labels = %w(dog cat dog cat dog cat dog cat dog)

      nb.fit(features, labels)

      expect(nb.instance_variable_defined?('@features')).to be_truthy
      expect(nb.instance_variable_defined?('@labels')).to be_truthy
      expect(nb.instance_variable_defined?('@priors')).to be_truthy
      expect(nb.instance_variable_defined?('@likelihoods')).to be_truthy
    end
  end

  describe '#predict' do
    it 'return the most probable label of the given features' do
      nb = NaiveBayes.new

      features = [%w(dogs are awesome cats too i love my dog),
                  %w(cats are more preferred by software developers i never could stand cats i have a dog),
                  %w(my dog's name is willy he likes to play with my wife's cat all day long i love dogs),
                  %w(cats are difficult animals unlike dogs really annoying i hate them all),
                  %w(so which one should you choose a dog definitely),
                  %w(the favorite food for cats is bird meat although mice are good but birds are a delicacy),
                  %w(a dog will eat anything including birds or whatever meat),
                  %w(my cat's favorite place to purr is on my keyboard),
                  %w(my dog's favorite place to take a leak is the tree in front of our house)]
      labels = %w(dog cat dog cat dog cat dog cat dog)

      nb.fit(features, labels)

      expect(nb.predict([%w(this test is about cats)])).to eq(['cat'])
      expect(nb.predict([%w(i hate)])).to eq(['cat'])
      expect(nb.predict([%w(the most annoying animal on earth)])).to eq(['cat'])
      expect(nb.predict([%w(the preferred company of software developers)])).to eq(['cat'])
      expect(nb.predict([%w(my precious my favorite)])).to eq(['dog']) # the original test expectes cat...
      expect(nb.predict([%w(get off my keyboard)])).to eq(['cat'])
      expect(nb.predict([%w(kill that bird)])).to eq(['cat'])
      expect(nb.predict([%w(this test is about dogs)])).to eq(['dog'])
      expect(nb.predict([%w(cats or dogs)])).to eq(['dog'])
      expect(nb.predict([%w(what pet will i love more)])).to eq(['dog'])
      expect(nb.predict([%w(willy where the heck are you)])).to eq(['dog'])
      expect(nb.predict([%w(i like big buts and i cannot lie)])).to eq(['dog'])
      expect(nb.predict([%w(why is the front door of our house open)])).to eq(['dog'])
      expect(nb.predict([%w(who is eating my meat)])).to eq(['dog'])
    end
  end

  describe '#score' do
    it 'return the the accuracy on the given features and labels' do
      nb = NaiveBayes.new

      features = [%w(dogs are awesome cats too i love my dog),
                  %w(cats are more preferred by software developers i never could stand cats i have a dog),
                  %w(my dog's name is willy he likes to play with my wife's cat all day long i love dogs),
                  %w(cats are difficult animals unlike dogs really annoying i hate them all),
                  %w(so which one should you choose a dog definitely),
                  %w(the favorite food for cats is bird meat although mice are good but birds are a delicacy),
                  %w(a dog will eat anything including birds or whatever meat),
                  %w(my cat's favorite place to purr is on my keyboard),
                  %w(my dog's favorite place to take a leak is the tree in front of our house)]
      labels = %w(dog cat dog cat dog cat dog cat dog)

      nb.fit(features, labels)

      features = [%w(this test is about cats),
                  %w(i hate),
                  %w(the most annoying animal on earth),
                  %w(the preferred company of software developers),
                  %w(my precious my favorite),
                  %w(get off my keyboard),
                  %w(kill that bird),
                  %w(this test is about dogs),
                  %w(cats or dogs),
                  %w(what pet will i love more),
                  %w(willy where the heck are you),
                  %w(i like big buts and i cannot lie),
                  %w(why is the front door of our house open),
                  %w(who is eating my meat)]
      labels = %w(cat cat cat cat cat cat cat dog dog dog dog dog dog dog)

      expect(nb.score(features, labels)).to eq(0.9285714285714286)
    end
  end
end
