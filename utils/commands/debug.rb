module Commands
  class Debug < Base
    ALIASES = %w[bindingpry binding.pry byebug bp bb dbg].freeze
    DESCRIPTION = 'Runs debugger in a context that provides some useful variables and methods such as: workbench, last, etc.'.freeze

    def execute_inner
      start_debug
    end

    private

    def last_request
      Env.requests.last
    end
  end
end
