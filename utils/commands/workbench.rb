module Commands
  class Workbench < Base
    ALIASES = %w[wb]
    DESCRIPTION = "Access workbench, printing it. May be called alone or with args to modify it. Pairs set values."
    ARGS = [
      ['subcommand', '[d]delete (followed by target key), [cp]copy (followed by target key and new key), [rn]rename (followed by target key and new name)'],
      ['target_key', 'Only on subcommands'],
      ['new_name', 'Only on subcommand [rename]']
    ]

    def execute
      subcommand = args[0]
      case subcommand
      when 'd'
        Env.workbench.delete(args[1].to_sym)
      when 'cp'
        Env.workbench[args[2].to_sym] = Env.workbench[args[1].to_sym]
      when 'rn'
        Env.workbench[args[2].to_sym] = Env.workbench[args[1].to_sym]
        Env.workbench.delete(args[1].to_sym)
      end

      pairs_to_workbench
      print_workbench
    end

    def pairs_to_workbench
      Env.workbench.merge!(args.pairs)
    end
  end
end
