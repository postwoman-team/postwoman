module Views
  module Commands
    module List
      module_function

      def success(loader_names, script_names)
        has_base = false
        formatted_loaders = loader_names.map do |loader_name|
          snakecased = snakecase(loader_name)
          if snakecased == 'base'
            has_base = true
            next
          end

          snakecased
        end.compact.sort.join(' ')
        formatted_loaders = "<hl>base</hl> #{formatted_loaders}" if has_base
        formatted_scripts = script_names.empty? ? "<fail>(#{I18n.t('common.empty')})</fail>" : script_names.join(' ')

        table = [
          ['<h2>Loaders</h2>'],
          [formatted_loaders],
          [' '],
          ['<h2>Scripts</h2>'],
          [formatted_scripts]
        ]
        table.map! { |a| [Style.apply(a[0])] }
        Style.table(table)
      end
    end
  end
end
