module Commands
  class Connect < Base
    ALIASES = %w[c].freeze
    DESCRIPTION = 'Runs a loader, making a request using the setted payload. Pairs overwrite params.'.freeze
    ARGS = {
      loader_name: "Wanted loader's name."
    }.freeze

    def execute
      loader_name_arg = positional_arg(0) || return
      loader_name = camelize(loader_name_arg)

      return puts Views::Commands::Connect.loader_not_found(loader_name) unless loader_exist?(loader_name)

      begin
        loader = Loaders.class_eval(loader_name).new(args)
        loader_payload = loader.load
      rescue Exception => e # rubocop:disable Lint/RescueException
        puts Views::Commands::Connect.loader_error(loader_name, e)
        return
      end

      request = Request.new(loader_payload)
      request.execute
      return puts Views.request(args, request) if request.failed?

      Env.requests << request
      puts Views.request(args, request)

      start_debug if args.flag?(:activate_debugger)
    end

    private

    def loader_exist?(loader_name)
      defined?(Loaders) && Loaders.const_defined?(loader_name)
    end
  end
end
