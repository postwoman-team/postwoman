module Views
  module Commands
    module Connect
      module_function

      def loader_not_found(name)
        str = '<fail>'
        str << I18n.t('commands.connect.not_found', name: name)
        str << '</fail>'
        Style.apply(str)
      end

      def loader_error(name, raised_error)
        str = '<fail>'
        str << I18n.t('commands.connect.loader_raised_error', name: name)
        str << '</fail><br>'
        str << raised_error.full_message
        Style.apply(str)
      end
    end
  end
end
