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
        formatted_scripts = script_names.join(' ')

        str = Style.table(
          [[formatted_loaders], [formatted_scripts]]
        )

        Style.apply(str)
      end
    end
  end
end
