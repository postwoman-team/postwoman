module Commands
  class Debug < Base
    def execute
      last = Env.requests.last
      byebug
    end
  end
end
