module ArgsHandler
  class Args
    attr_reader :positionals, :pairs, :flags

    FLAGS = {
      no_headers: 'nh',
      no_body: 'nb',
      no_loader_payload: 'nl',
      activate_binding_pry: 'bb',
      apply_workbench: 'wb'
    }

    def initialize(positionals, pairs, flags)
      @positionals = positionals
      @pairs = pairs
      @flags = flags
    end

    def [](key)
      return positionals[key + 1] if key.instance_of?(Integer)

      pairs[key]
    end

    def key?(key)
      pairs.key?(key)
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

    def command_klass
      fetch_command_names.each do |command_name|
        command_klass = Commands.class_eval(command_name)
        same_name = command_klass.name.split('::')[1].downcase == raw_command
        same_name_as_alias = command_klass::ALIASES.include?(raw_command)
        return command_klass if same_name || same_name_as_alias
      end
      false
    end

    def flag?(name)
      wanted_flag = FLAGS[name.to_sym]
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
