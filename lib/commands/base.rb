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

    def edit_loader(name)
      system("#{Env.config[:editor]} loaders/#{name}.rb")
    end

    def edit_helper(name)
      system("#{Env.config[:editor]} loaders/utils/#{name}.rb")
    end

    def new_or_edit(file_name, path, default_content, label)
      path = "#{path}#{file_name}.rb"

      if File.exist?(path)
        puts Views::Commands::Base.editing(label)
        return puts Views::Commands::Base.editor_not_found_error if Env.config[:editor].nil?

        return system("#{Env.config[:editor]} #{path}")
      end

      puts Views::Commands::Base.creating(label)
      File.open(path, 'w') do |f|
        f.write(default_content)
      end

      return puts Views::Commands::Base.editor_not_found_warning if Env.config[:editor].nil?

      system("#{Env.config[:editor]} #{path}")
    end

    def obrigatory_positional_arg(index, custom_name = nil)
      positional_names = self.class::ARGS.keys
      name = custom_name || positional_names[index]
      value = args[index]
      return puts Views::Commands::Base.missing_positional_argument(index + 1, name) unless value

      value
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
