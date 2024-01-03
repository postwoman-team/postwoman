module Commands
  class Workbenchpush < Base
    ALIASES = %w[wbp]
    DESCRIPTION = 'Brings wanted key-values from last request to workbench. Works for responses in XML and JSON. Searches recursively until first match.'
    ARGS = {
      wanted_keys: '(Can stack) The keys you want to be pulled.'
    }

    def execute
      workbench.merge!(args.pairs)
      request = Env.requests.last
      return unless request

      selector = positional_arg(0)
      query = positional_arg(1)
      return unless query && selector

      result = request.response_query(selector, query)
      return unless result

      workbench['test'] = result

      puts Views.workbench
    end
  end
end
