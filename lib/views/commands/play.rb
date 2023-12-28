module Views
  module Commands
    module Play
      module_function

      def script_not_found(name)
        str = '<fail>'
        str << I18n.t('commands.play.not_found', name: name)
        str << '</fail>'
        Style.apply(str)
      end
    end
  end
end
