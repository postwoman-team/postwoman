module Loaders
  module Builtin
    class Base
      attr_reader :args, :env # could be removed?

      @@trait_variables = {}

      def initialize(args)
        @args = args
        @env = {}
        add_default_trait_to_env
        add_traits_to_env
        apply_workbench if args.flag?(:apply_workbench)
        add_pairs_to_env
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
        traits = klass_traits
        traits[name] = {} unless traits.key?(name)
        traits[name].merge!(values)
      end

      def self.klass_traits
        @@trait_variables[name] = {} unless @@trait_variables.key?(name)
        @@trait_variables[name]
      end

      def self.fetch_traits
        traits = {}
        ancestors.reverse[7..].each do |ancestor|
          merge_traits(traits, ancestor.klass_traits)
        end
        merge_traits(traits, klass_traits)
        traits
      end

      def self.merge_traits(traits, new_traits)
        new_traits.each do |name, values|
          if traits.key?(name)
            traits[name].merge!(values)
          else
            traits[name] = values
          end
        end
      end

      private

      def traits
        @traits ||= self.class.fetch_traits
      end

      def params_with_env
        env.reduce(params) do |final_params, (k, v)|
          next final_params unless final_params.key?(k)

          final_params.merge(k => v)
        end
      end

      def method_missing(m, *_args)
        return env[m] if env.keys.include?(m)

        puts "Tried to find '#{m}' but failed.".yellow
      end

      def apply_workbench
        env.merge!(Env.workbench)
      end

      def add_pairs_to_env
        env.merge!(args.pairs.dup)
      end

      def add_default_trait_to_env
        env.merge!(traits[:default]) if traits.key?(:default)
      end

      def add_traits_to_env
        traits.each do |trait, variables|
          next if trait == :default
          next unless input_key?(trait)

          env.merge!(variables)
        end
      end

      def input_key?(key)
        args.key?(key) || (Env.workbench.key?(key) && args.flag?(:apply_workbench))
      end

      def url
        'http://example.org/'
      end

      def http_method
        :get
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
