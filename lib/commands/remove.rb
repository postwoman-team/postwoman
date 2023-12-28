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
      return puts Views::Commands::New.invalid_category(name) unless 'ls'.include?(category_char)

      if category_char == 'l'
        return puts "Please don't delete base.".yellow if name == 'base'

        category = 'loader'
      else
        category = 'script'
      end

      return puts "Could not find #{category} #{name}".yellow unless File.exist?("#{category}s/#{name}.rb")

      File.delete("#{category}s/#{name}.rb")
      puts "Successfully removed #{category} #{name}".green
    end
  end
end
