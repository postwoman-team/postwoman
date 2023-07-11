module Commands
  class Remove < Base
    ALIASES = %w[rm delete del]
    DESCRIPTION = "Delete loader"
    ARGS = [
      ['name', 'Loaders name']
    ]

    def execute
      loader_name = args[0]
      path = "loaders/#{loader_name}.rb"

      return puts "Could not find loader #{loader_name}".yellow unless File.exist?(path)
      return puts "Please don't delete base.".yellow if loader_name == 'base'
      File.delete(path)
      puts "Successfully removed loader #{loader_name}".green
    end
  end
end
