module PartialViews
  module Request
    class Full
      def initialize(args, request)
        @args = args
        @request = request
      end

      def print
        Payload.new(@request.payload).print unless @args.flag?(:no_loader_payload)
        ResponseHeaders.new(@request.headers, @args.flag?(:no_headers)).print
        ResponseBody.new(@request, @args.flag?(:no_body)).print
        print_request_status
      end

      private

      def print_request_status
        print_table("Status: #{@request.pretty_status}", @request.url)
      end
    end
  end
end
