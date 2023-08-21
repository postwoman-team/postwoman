module Commands
  class Debug < Base
    ALIASES = %w[bindingpry binding.pry byebug bp bb dbg].freeze
    DESCRIPTION = 'Runs debugger in a context that provides some useful variables and methods such as: workbench, last, etc.'.freeze

    def execute
      last = Env.requests.last
      start_debug
    end
  end
end
