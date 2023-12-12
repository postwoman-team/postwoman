module Commands
  class Help < Base
    ALIASES = %w[h].freeze
    DESCRIPTION = 'Shows this message.'.freeze

    def execute_inner
      help_page = args[0]

      case help_page
      when 'commands'
        commands_page
      when 'flags'
        flags_page
      when 'general'
        generals_page
      else
        welcome_page
      end
    end

    def welcome_page
      puts 'Welcome to Postwoman, your CLI API platform.'
      puts
      print_table(
        ['Type one of the following commands to learn more about the application:'],
        ['> help' + ' general'.green],
        ['> help' + ' flags'.green],
        ['> help' + ' commands'.green]
      )
    end

    def generals_page
      print_table(
        ['Commands takes the form of'],
        ['> command positional_arg1 positional_arg2 -flag -flag2 mypair:value'.green],
        ['Its safe to type flags and pairs in random orders, but positionals might break if theyre not on the start of the command.'],
        [' '],
        ['Loaders:'.green],
        ['Loaders are basically payload generators. They define the whole payload as a Ruby class.'],
        [' '],
        ['Pairs:'.green],
        ['Pairs are defined by key:value, where the ":" MUST be stick together to its value. Pairs written as key: are also valid and describe empty pairs, which are used specially for loader traits.'],
        [' '],
        ['Pair values types and rules:'.green],
        ['Values will be string by default, unless its a special keyword. Nil, null, true, false, and numbers are special keywords which will be interpreted accordingly when the command is parsed. To force String typing, surround your value with double or single quotes. This is also useful if you string has whitespaces.']
      )
    end

    def flags_page
      puts 'Flags:'
      print_table(
        ['Flags will be applied to any command as long as it makes sense. It can be placed anywhere on the command except for the first keyword (which is the command itself).'],
        [' '],
        *flags_rows
      )
    end

    def flags_rows
      ArgsHandler::Args::FLAGS.map do |expanded, actual|
        ["-#{actual}".green + " #{expanded.to_s.gsub('_', ' ')}"]
      end
    end

    def commands_page
      puts 'Commands:'
      rows = []
      fetch_command_names.each do |command_name|
        rows += Commands.class_eval(command_name).help_rows
        rows += [[' ']]
      end
      print_table(*rows)
    end
  end
end
