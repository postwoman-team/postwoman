module Views
  module Commands
    module Workbench
      module_function

      def invalid_subcommand(name)
        str =  '<warning>'
        str << I18n.t('commands.workbench.invalid_subcommand', name:)
        str << '</warning>'

        Style.apply(str)
      end

      def key_not_found_error(name)
        str =  '<fail>'
        str << I18n.t('commands.workbench.key_not_found', name:)
        str << '</fail>'

        Style.apply(str)
      end

      def key_not_found_warning(name)
        str =  '<warning>'
        str << I18n.t('commands.workbench.key_not_found', name:)
        str << '</warning>'

        Style.apply(str)
      end

      def key_already_exists(name)
        str =  '<fail>'
        str << I18n.t('commands.workbench.key_already_exists', name:)
        str << '</fail>'

        Style.apply(str)
      end

      def subcommand_needs_positionals
        str =  '<fail>'
        str << I18n.t('commands.workbench.subcommand_needs_positionals')
        str << '</fail>'

        Style.apply(str)
      end
    end
  end
end
