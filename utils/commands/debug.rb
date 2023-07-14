module Commands
  class Debug < Base
    ALIASES = %w[bindingpry binding.pry bp bb dbg].freeze
    DESCRIPTION = 'Runs binding.pry in a context.'.freeze

    def execute
      last = Env.requests.last
      binding.pry
    end
  end
end
