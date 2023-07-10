module ArgsHandler
  class Args
    attr_reader :positionals, :pairs, :flags
    def initialize(positionals, pairs, flags)
      @positionals = positionals
      @pairs = pairs
      @flags = flags
    end

    def [](key)
      return positionals[key+1] if key.class == Integer
      pairs[key]
    end

    def has_key?(key)
      pairs.has_key?(key)
    end

    def command?
      positionals.first != ''
    end

    def only_command?
      pairs.empty? && flags.empty? && positionals.length == 1
    end

    def raw_command
      positionals.first
    end

    def command
      case
      when raw_command_in(%w(c connect r))
        'run'
      when raw_command_in(%w(byebug bb dbg))
        'debug'
      when raw_command == 'wb'
        'workbench'
      when raw_command == 'wbp'
        'workbenchpush'
      when raw_command == 'l'
        'last'
      when raw_command == 'exit'
        'quit'
      when raw_command_in(%w(nh eh edithelper))
        'newhelper'
      when raw_command_in(%w(n e edit))
        'new'
      else
        raw_command
      end
    end

    def flag?(name)
      wanted_flag = {
        no_headers: 'nh',
        no_body: 'nb',
        no_loader_payload: 'nl',
        activate_byebug: 'bb',
        apply_workbench: 'wb'
        }[name.to_sym]
      flags.include?(wanted_flag)
    end

    def pair(key)
      @pairs[key]
    end

    private

    def raw_command_in(aliases)
      aliases.include? raw_command
    end
  end
end
