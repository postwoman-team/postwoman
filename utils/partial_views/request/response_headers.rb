module PartialViews
  module Request
    class ResponseHeaders
      def initialize(headers, hidden)
        @headers = headers
        @hidden = hidden
      end

      def print
        return print_hidden if @hidden

        print_not_hidden
      end

      private

      def print_not_hidden
        print_table(title)
        print_table(
          *@headers.to_a
        )
      end

      def print_hidden
        print_table("#{title.uncolorize} (Hidden)".gray)
      end

      def title
        'Headers'.purple
      end
    end
  end
end
