module Commands
  class Pwd < Base
    DESCRIPTION = 'Show current directory'.freeze

    def execute
      puts Dir.pwd
    end
  end
end
