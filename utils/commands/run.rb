module Commands
  class Run < Base
    def execute
      loader_name = camelize(args[0])

      return puts('No loader found: '.red + loader_name) unless loader_exist?(loader_name)

      begin
        loader = Loaders.class_eval(loader_name).new(args)
        loader_payload = loader.load
      rescue StandardError => e
        puts e.full_message
        return
      end

      return if loader.failed?

      request = Request.new(loader_payload)
      return if request.failed?

      Env.requests << request
      display_request(request)
    end

    private

    def loader_exist?(loader_name)
      defined?(Loaders) && Loaders.const_defined?(loader_name)
    end
  end
end
