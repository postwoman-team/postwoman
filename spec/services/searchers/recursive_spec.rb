require 'spec_helper'

describe Searchers::Recursive do 
  context '#search' do 
    context 'Receives a block and executes the block with each match for the given key' do 
      it 'through a simple hash' do 
        hash = { foo: 'bar' }

        results = []
        result = Searchers::Recursive.new(hash).search(:foo) { |result| results << result + '2' }

        expect(results).to eq(['bar2'])
      end

      it 'through a nested hash' do 
        nested_hash = { foo: 'bar', ziggs: { foo: 'bebe' } }

        results = []
        result = Searchers::Recursive.new(nested_hash).search(:foo) { |result| results << result + '2' }

        expect(results).to eq(['bar2', 'bebe2'])
      end

      it 'through a double nested hash' do 
        double_nested_hash = { foo: 'bar', ziggs: { moon: { foo: 'bebe'} } }

        results = []
        result = Searchers::Recursive.new(double_nested_hash).search(:foo) { |result| results << result + '2' }

        expect(results).to eq(['bar2', 'bebe2'])
      end

      it 'through an array of hashes' do 
        hash_array = [{ foo: 'bar' }, { foo: 'bebe' }]

        results = []
        result = Searchers::Recursive.new(hash_array).search(:foo) { |result| results << result + '2' }

        expect(results).to eq(['bar2', 'bebe2'])
      end
    end
  end

  context '#search_first' do 
    context 'Searchers the given key recursively and return the first match' do 
      it 'through a simple hash' do 
        hash = { foo: 'bar', bebe: { foo: 'xum' } }
    
        result = Searchers::Recursive.new(hash).search_first(:foo)
        
        expect(result).to eq 'bar'
      end
    end
  end

  context '#search_results' do 
    context 'Searches the given key recursively and return an array with all matches' do 
      it 'through a collection' do 
        hash = { foo: 'bar', bebe: { foo: 'xum' } }
    
        result = Searchers::Recursive.new(hash).search_results(:foo)
        
        expect(result).to eq ['bar', 'xum']
      end
    end
  end
end