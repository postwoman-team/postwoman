module PartialViews
  module Request
    class ResponseBody
      def initialize(request, hidden)
        @request = request
        @hidden = hidden
      end

      def print
        return print_hidden if @hidden

        print_not_hidden
      end

      private

      def print_not_hidden
        print_table(title)
        puts '↓Empty' if @request.pretty_body.empty?
        print_table(@request.pretty_body)
      end

      def print_hidden
        print_table("#{title.uncolorize} (Hidden)".gray)
      end

      def title
        "#{'Body'.purple} - #{@request.content_type.yellow}"
      end
    end
  end
end
