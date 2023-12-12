module Commands
  class Workbenchpush < Base
    ALIASES = %w[wbp]
    DESCRIPTION = 'Brings wanted key-values from last request to workbench. Works for responses in XML and JSON. Searches recursively until first match.'
    ARGS = {
      wanted_keys: '(Can stack) The keys you want to be pulled.'
    }

    def execute_inner
      pairs_to_workbench
      last_request_to_worbench
      puts Views.workbench
    end

    private

    def last_request_to_worbench
      return if args.positionals.length == 1
      return puts 'Cant pull desired values because no requests were made at the moment.'.yellow if Env.requests.empty?

      request = Env.requests[-1]

      body = if request.response_json?
               request.parsed_body
             else
               Nori.new.parse(request.body)
             end

      args.positionals[1..].each do |positional|
        if find_key_value_recursive(body, positional)
          puts "Pulled \"#{positional}\" :>".green
        else
          puts "Couldnt pull \"#{positional}\" :<".yellow
        end
      end
    end

    def find_key_value_recursive(hash, key)
      if hash[key]
        Env.workbench[key.to_sym] = hash[key]
        return true
      end

      hash.each do |_, value|
        if value.instance_of?(Hash)
          subhash = value
          return true if find_key_value_recursive(subhash, key)
        elsif value.instance_of?(Array)
          value.each do |array_element|
            return true if array_element.instance_of?(Hash) && find_key_value_recursive(array_element, key)
          end
        end
      end
      false
    end

    def pairs_to_workbench
      Env.workbench.merge!(args.pairs)
    end
  end
end
