module Views
  module Commands
    module List
      module_function

      def success(loader_names)
        has_base = false
        str = loader_names.map do |loader_name|
          snakecased = snakecase(loader_name)
          next has_base = true if snakecased == 'base'

          snakecased
        end.join(' ')

        str = "<highlight>base</highlight> #{str}" if has_base

        Style.apply("<box>#{str}</box>")
      end
    end
  end
end
