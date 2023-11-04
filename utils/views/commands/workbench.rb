module Views
  module Commands
    module Workbench
      module_function
      def key_not_found_error(name)
        str =  '<fail>'
        str << I18n.t('commands.workbench.key_not_found', name: name)
        str << '</fail>'

        Style.apply(str)
      end

      def key_not_found_warning(name)
        str =  '<warning>'
        str << I18n.t('commands.workbench.key_not_found', name: name)
        str << '</warning>'

        Style.apply(str)
      end

      def key_already_exists(name)
        str =  '<fail>'
        str << I18n.t('commands.workbench.key_already_exists', name: name)
        str << '</fail>'

        Style.apply(str)
      end
    end
  end
end
