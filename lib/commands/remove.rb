module Commands
  class Remove < Base
    ALIASES = %w[rm delete del].freeze
    DESCRIPTION = 'Delete loader'.freeze
    ARGS = {
      category: "Category of the file. 's' for script, 'l' for loader",
      name: 'File name in snake case.'
    }.freeze

    def execute
      category_char = positional_arg(0)&.downcase || return
      name = positional_arg(1)&.downcase || return
      return puts Views::Commands::New.invalid_category(category_char) unless 'ls'.include?(category_char)

      if category_char == 'l'
        return puts Views::Commands::Remove.dont_delete_base if name == 'base'

        category = 'loader'
      else
        category = 'script'
      end

      return puts Views::Commands::Remove.file_not_found(name, category) unless File.exist?("#{category}s/#{name}.rb")

      File.delete("#{category}s/#{name}.rb")
      puts puts Views::Commands::Remove.success(name, category)
    end
  end
end
