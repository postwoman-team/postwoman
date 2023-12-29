module Commands
  class Base
    ALIASES = [].freeze
    DESCRIPTION = ''.freeze
    ARGS = {}.freeze

    attr_reader :args

    def initialize(args)
      @args = args
    end

    def execute; end

    def self.help_rows
      command_name = name.split('::')[1].upcase
      [
        ["#{command_name.green} (#{self::ALIASES.join(', ')})".green],
        ["> #{command_name.downcase} #{self::ARGS.map { |name, _| "<#{name}>" }.join(' ')}".gray],
        *args_rows,
        [self::DESCRIPTION]
      ]
    end

    def self.args_rows
      return [] if self::ARGS.empty?

      self::ARGS.map do |name, description|
        ["#{name.to_s.yellow} → #{description}"]
      end
    end

    private

    def workbench
      Env.workbench
    end

    def positional_arg(index, custom_name = nil)
      positional_names = self.class::ARGS.keys
      name = custom_name || positional_names[index]
      value = args[index]
      return puts Views::Argument.missing_positional_argument(index + 1, name) unless value

      value
    end

    def category_arg(index)
      category_char = positional_arg(index)&.downcase

      return puts Views::Argument.invalid_category(category_char) if category_char && !'ls'.include?(category_char)

      category_char == 'l' ? 'loader' : 'script'
    end

    def start_debug
      case Env.config[:debugger]
      when 'pry'
        binding.pry
      when 'debug'
        binding.break
      end
    end
  end
end
