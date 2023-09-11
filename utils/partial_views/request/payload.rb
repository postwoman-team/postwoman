module PartialViews
  module Request
    class Payload
      def initialize(payload)
        @payload = payload
      end

      def print
        print_table('Loader Arguments'.purple)
        print_table(JSON.pretty_generate(@payload))
      end
    end
  end
end
