module Searchers
  class Recursive

    attr_reader :hash

    def initialize(hash)
      @hash = hash 
    end

    def search(key, &block)
      yield(hash[key]) if block_given? && hash.has_key?(key)
      return hash[key] if hash.has_key?(key)

      hash.each_value do |value|
        @hash = value 
        return hash if value.is_a?(Hash) && search(key, &block)

        if value.is_a?(Array)
          value.each do |element| 
            @hash = element 
            return hash if search(key, &block)
          end
        end
      end
    end
  end
end