module Commands
  class Debug < Base
    ALIASES = %w[bindingpry binding.pry bp bb dbg]
    DESCRIPTION = 'Runs binding.pry in a context.'
    ARGS=[]

    def execute
      last = Env.requests.last
      binding.pry
    end
  end
end
