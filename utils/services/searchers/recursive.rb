module Searchers
  class Recursive

    attr_reader :collection

    def initialize(collection)
      @collection = collection
    end

    def search_first(key)
      search(key) { |result| return result }
    end

    def search_results(key)
      results = []
      search(key) { |result| results << result }
      results
    end

    def search(key, &block)  
      yield collection[key] if collection_has_key?(key)

      if collection.is_a?(Hash) || collection.is_a?(Array)
        collection.each do |element|
          @collection = element
          search(key, &block)
        end
      end
    end

    private 

    def collection_has_key?(key)
      collection.is_a?(Hash) && collection.has_key?(key)
    end
  end
end