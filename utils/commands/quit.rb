module Commands
  class Quit < Base
    ALIASES = %w[exit]
    DESCRIPTION = "Exits the application"
    ARGS = []

    def execute
      exit
    end
  end
end
