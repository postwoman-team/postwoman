module Loaders
  module Builtin
    class Base
      attr_reader :args, :env

      @@trait_variables = {}

      def initialize(args)
        @failed = false
        @args = args
        @env = args.pairs.dup
        add_traits_to_env
        apply_workbench if args.flag?(:apply_workbench)
      end

      def load
        {
          http_method: http_method,
          url: checked_url,
          params: params_with_env,
          headers: headers
        }
      end

      def self.trait(name, values)
        @@trait_variables[name] = {} unless @@trait_variables.has_key?(name)
        @@trait_variables[name].merge!(values)
      end

      def failed?
        @failed
      end

      private

      def apply_workbench
        env.merge!(Env.workbench)
      end

      def checked_url
        parsed_url = URI.parse(url)
        return parsed_url if parsed_url.class != URI::Generic

        error("Invalid url from loader: #{url}")
      end

      def error(message)
        puts message.red
        @failed = true
      end

      def params_with_env
        env.reduce(params) do |final_params, (k, v)|
          next final_params unless final_params.has_key?(k)
          final_params.merge(k => v)
        end
      end

      def method_missing(m, *_args)
        return env[m] if env.keys.include?(m)

        puts "Tried to call missing method '#{m}' but failed.".yellow
      end

      def add_traits_to_env
        @@trait_variables.each do |trait, variables|
          @env = variables.merge(env) if args.has_key?(trait) || trait == :default
        end
      end

      def http_method
        :get
      end

      def url
        'https://github.com/Hikari-desuyoo'
      end

      def params
        {}
      end

      def headers
        {}
      end
    end
  end
end
