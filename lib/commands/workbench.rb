module Commands
  class Workbench < Base
    ALIASES = %w[wb].freeze
    DESCRIPTION = 'Access workbench, printing it. May be called alone or with args to modify it. Pairs set values.'.freeze
    ARGS = {
      subcommand: '[d]delete (followed by target key), [cp]copy (followed by target key and new key), [rn]rename (followed by target key and new name)',
      target_key: 'Used on (all) subcommands',
      second_arg: 'Only on subcommands [rename] and [copy]'
    }.freeze

    def execute
      subcommand = args[0]
      case subcommand
      when 'd'
        delete_subcommand
      when 'cp'
        copy_subcommand
      when 'rn'
        rename_subcommand
      when nil
      else
        puts Views::Argument.invalid_subcommand(subcommand)
      end

      pairs_to_workbench
      puts Views.workbench
    end

    private

    def rename_subcommand
      original_key = positional_arg(1, 'key to rename')&.to_sym
      new_name = positional_arg(2, 'new name')&.to_sym
      return unless original_key && new_name
      return puts Views::Commands::Workbench.key_not_found_error(original_key) unless workbench.key?(original_key)
      return puts Views::Commands::Workbench.key_already_exists(new_name) if workbench.key?(new_name)

      workbench[new_name] = workbench[original_key]
      workbench.delete(original_key)
    end

    def copy_subcommand
      copy_key = positional_arg(1, 'key to copy')&.to_sym
      resulting_key = positional_arg(2, 'resulting key')&.to_sym
      return unless copy_key && resulting_key
      return puts Views::Commands::Workbench.key_not_found_error(copy_key) unless workbench.key?(copy_key)

      workbench[resulting_key] = workbench[copy_key]
    end

    def delete_subcommand
      keys = args.positionals[2..]

      puts Views::Argument.subcommand_needs_positionals if keys.empty?
      keys.map(&:to_sym).each do |key|
        puts Views::Commands::Workbench.key_not_found_warning(key) unless workbench.key?(key)
        workbench.delete(key)
      end
    end

    def pairs_to_workbench
      workbench.merge!(args.pairs)
    end
  end
end
