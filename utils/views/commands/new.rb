module Views
  module Commands
    module New
      module_function

      def invalid_loader_name(name)
        str =  '<fail>'
        str << I18n.t('commands.new.invalid_loader_name', name:)
        str << '</fail>'

        Style.apply(str)
      end
    end
  end
end
