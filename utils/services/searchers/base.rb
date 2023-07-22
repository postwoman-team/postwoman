module Searchers
  class Base

    attr_reader :hash, :key 

    def initialize(hash:, key:)
      @hash = hash 
      @key = key 
    end

    def recursive_search
      return hash if hash.has_key?(key)

      hash.each_value do |value|
        @hash = value 
        return hash if value.is_a?(Hash) && recursive_search

        if value.is_a?(Array)
          value.each do |element| 
            @hash = element 
            return hash if recursive_search
          end
        end
      end
    end
  end
end