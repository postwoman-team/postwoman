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

      def subcommand_needs_positionals
        str =  '<fail>'
        str << I18n.t('commands.base.subcommand_needs_positionals')
        str << '</fail>'

        Style.apply(str)
      end

      def missing_positional_argument(index, name)
        str =  '<fail>'
        str << I18n.t('commands.base.missing_positional_argument', index: index, name: name)
        str << '</fail>'

        Style.apply(str)
      end
    end
  end
end
