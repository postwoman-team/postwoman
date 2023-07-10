module Commands
  class Workbench < Base
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
