module Commands
  class Run < Base
    ALIASES = %w[c connect r]
    DESCRIPTION = 'Runs a loader, making a request using the setted payload. Pairs overwrite params.'
    ARGS = {
      loader_name: "Wanted loader's name."
    }.freeze

    def execute
      loader_name_arg = obrigatory_positional_arg(0) || return
      loader_name = camelize(loader_name_arg)

      return puts("No loader found: '#{loader_name}'".red) unless loader_exist?(loader_name)

      begin
        loader = Loaders.class_eval(loader_name).new(args)
        loader_payload = loader.load
      rescue Exception => e
        puts "Your loader '#{loader_name}' raised an exception:".red
        puts e.full_message
        return
      end

      return if loader.failed?

      request = Request.new(loader_payload)
      request.execute
      return print_payload(request.payload) if request.failed?

      Env.requests << request
      display_request(request)
    end

    private

    def loader_exist?(loader_name)
      defined?(Loaders) && Loaders.const_defined?(loader_name)
    end
  end
end
