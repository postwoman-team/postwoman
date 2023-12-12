module Commands
  class List < Base
    ALIASES = %w[ls all loaders].freeze
    DESCRIPTION = 'Lists all loaders'.freeze

    def execute_inner
      puts Views::Commands::List.success(fetch_loader_names)
    end
  end
end
