module Commands
  class Quit < Base
    ALIASES = %w[exit].freeze
    DESCRIPTION = 'Exits the application'.freeze

    def execute
      exit
    end
  end
end
