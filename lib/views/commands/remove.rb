module Views
  module Commands
    module Remove
      module_function

      def success(name, category)
        str = '<success>'
        str << I18n.t('commands.remove.success', name: name, category: category)
        str << '</success>'
        Style.apply(str)
      end

      def dont_delete_base
        str = '<fail>'
        str << I18n.t('commands.remove.dont_delete_base')
        str << '</fail>'
        Style.apply(str)
      end

      def file_not_found(name, category)
        str = '<fail>'
        str << I18n.t('commands.remove.file_not_found', name: name, category: category)
        str << '</fail>'
        Style.apply(str)
      end
    end
  end
end
