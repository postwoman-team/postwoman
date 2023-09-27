module PrintElement
  module Request
    module_function

    def successful(args, request)
      unless args.flag?(:no_loader_payload)
        print_table('Loader Arguments'.purple)
        print_table(JSON.pretty_generate(request.payload))
      end

      if args.flag?(:no_headers)
        print_table("Headers (Hidden)".gray)
      else
        print_table('Headers'.purple)
        print_table(
          *request.headers.to_a
        )
      end

      if args.flag?(:no_body)
        content_type_text = " - #{request.content_type}" if request.content_type
        print_table("Body#{content_type_text.to_s} (Hidden)".gray)
      else
        content_type_text = " - #{request.content_type.yellow}" if request.content_type
        print_table('Body'.purple + content_type_text.to_s)
        puts '↓Empty' if request.pretty_body.empty?
        print_table(request.pretty_body)
      end

      print_table("Status: #{request.pretty_status}", request.url)
    end

    def failed(request)
      print_table('Loader Arguments'.purple)
      print_table(JSON.pretty_generate(request.payload))
    end
  end
end
