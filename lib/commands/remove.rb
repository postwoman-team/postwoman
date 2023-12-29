module Commands
  class Remove < Base
    ALIASES = %w[rm delete del].freeze
    DESCRIPTION = 'Delete loader'.freeze
    ARGS = {
      category: "Category of the file. 's' for script, 'l' for loader",
      name: 'File name in snake case.'
    }.freeze

    def execute
      category = category_arg(0)
      name = positional_arg(1)&.downcase

      return unless category && name

      return puts Views::Commands::Remove.dont_delete_base if name == 'base' && category == 'loader'

      return puts Views::Commands::Remove.file_not_found(name, category) unless File.exist?("#{category}s/#{name}.rb")

      File.delete("#{category}s/#{name}.rb")
      puts Views::Commands::Remove.success(name, category)
    end
  end
end
