module Commands
  class Workbenchpush < Base
    ALIASES = %w[wbp]
    DESCRIPTION = 'Brings wanted key-values from last request to workbench. Works for responses in XML and JSON. Searches recursively until first match.'
    ARGS = {
      wanted_keys: '(Can stack) The keys you want to be pulled.'
    }

    def execute
      pairs_to_workbench
      push_from_last_request_to_workbench
      print_workbench
    end

    private

    def push_from_last_request_to_workbench
      return if args.positionals.length == 1
      return puts 'Cant pull desired values because no requests were made at the moment.'.yellow if Env.no_requests?

      request = Env.last_request

      body = if request.response_json?
               request.parsed_body
             else
               Nori.new.parse(request.body)
             end

      args.positionals[1..].each do |positional|
        Searchers::Recursive.new(body).search_first(positional) do |pull|
          if pull
            push_to_workbench(positional, pull)
            puts "Pulled \"#{positional}\" :>".green
          else
            puts "Couldnt pull \"#{positional}\" :<".yellow
          end
        end
      end
    end

    def pairs_to_workbench
      Env.workbench.merge!(args.pairs)
    end

    def push_to_workbench(key, value)
      Env.workbench[key.to_sym] = value
    end
  end
end
