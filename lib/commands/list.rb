module Commands
  class List < Base
    ALIASES = %w[ls all loaders].freeze
    DESCRIPTION = 'Lists all loaders'.freeze

    def execute
      puts Views::Commands::List.success(fetch_loader_names, Script.names)
    end
  end
end
