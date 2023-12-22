module ArgsHandler
  class Parser
    attr_reader :pairs, :positionals, :flags

    def initialize(args)
      @tokens = tokenize(args)
      @positionals = []
      @pairs = []
      @flags = []
      parse(@tokens)
    end

    private

    def pop_next_value
      @tokens.shift[1]
    end

    def pop_next_token
      @tokens.shift
    end

    def new_pair(key)
      pairs << [key.to_sym, nil]
    end

    def new_flag(flag)
      flags << flag
    end

    def new_positional(positional)
      positionals << positional
    end

    def value_to_last_pair(value)
      pairs.last[1] = value
    end

    def last_pair_has_value?
      return true if pairs.empty?
      !pairs.last[1].nil?
    end

    def treat_value(value)
      case value
      when 'true'
        true
      when 'false'
        false
      when /^[0-9]*$/
        value.to_i
      when /^(nil|null)$/
        nil
      else
        value
      end
    end

    def allocate_word(value)
      return new_positional(value) if last_pair_has_value?
      value_to_last_pair(value)
    end

    def parse(tokens)
      until @tokens.empty?
        token = pop_next_token
        kind, value = token

        case kind
        when :HIPHEN
          new_flag(pop_next_value)
        when :COLON
          value_to_last_pair(pop_next_value)
        when :KEY
          new_pair(value)
        when :QUOTED_WORD
          allocate_word(value)
        when :WORD
          value = treat_value(value)
          allocate_word(value)
        end
      end
      @pairs = pairs.to_h
    end

    def tokenize(args)
      scanner = StringScanner.new(args)
      tokens = []

      until scanner.eos?
        scanner.skip(/(\s+)/)
        case
        when token = scanner.scan(/("|')/)
          other_quote = scanner.scan_until(%r((?<!\\)#{token}))
          tokens << [:QUOTED_WORD, other_quote[..-2]]
        when scanner.scan(/-/)
          tokens << [:HIPHEN, nil]
        else
          word = scanner.scan_until(/(:|\s|$)/).strip
          if word[-1] == ':'
            tokens << [:KEY, word[..-2]]
          else
            tokens << [:WORD, word]
          end
        end
      end
      tokens
    end
  end
end
