module Views
  module Commands
    module Base
      module_function

      def invalid_subcommand(name)
        str =  '<warning>'
        str << I18n.t('commands.base.invalid_subcommand', name: name)
        str << '</warning>'

        Style.apply(str)
      end

      def show_command_help(command_name, aliases, args, example)
        command_name = command_name.split('::')[1].downcase

        str =  '<box>'
        str << '<h2>'
        str << command_name.upcase
        str << ' ('
        str << aliases.join(', ')
        str << ')'
        str << '</h2></box>'

        usage_str = '<disabled>'
        usage_str << command_name
        usage_str << ' '
        usage_str << args.keys.map { |arg| "<#{arg}>" }.join(' ')
        usage_str << '</disabled>'

        example_str = '<command>'
        example_str << example
        example_str << '</command>'

        str << Style.table(
          [
            ["<hl>#{I18n.t('common.usage')}</hl>",       usage_str],
            ["<hl>#{I18n.t('common.example')}</hl>",     example_str],
            ["<hl>#{I18n.t('common.description')}</hl>", I18n.t("commands.#{command_name}.description")]
          ],
          protect: false
        )

        Style.apply(str)
      end

      def subcommand_needs_positionals
        str =  '<fail>'
        str << I18n.t('commands.base.subcommand_needs_positionals')
        str << '</fail>'

        Style.apply(str)
      end

      def missing_positional_argument(index, name)
        str =  '<fail>'
        str << I18n.t('commands.base.missing_positional_argument', index:, name: name)
        str << '</fail>'

        Style.apply(str)
      end

      def editor_not_found_warning
        str =  '<warning>'
        str << I18n.t('commands.base.editor_not_found')
        str << '</warning>'

        Style.apply(str)
      end

      def editor_not_found_error
        str =  '<fail>'
        str << I18n.t('commands.base.editor_not_found')
        str << '</fail>'

        Style.apply(str)
      end

      def editing(name)
        str =  '<box>'
        str << I18n.t('commands.base.editing', name: name)
        str << '</box>'

        Style.apply(str)
      end

      def creating(name)
        str =  '<box><success>'
        str << I18n.t('commands.base.creating', name: name)
        str << '</success></box>'

        Style.apply(str)
      end
    end
  end
end
