module Views
  module Error
    module_function

    def tracing(exception)
      str =  '<box><h2>'
      str << exception.class.name
      str << '</h2></box>'
      str << '<box>'
      str << '<fail>'
      str << exception.message
      str << '</fail>'
      str << ' <br>'
      str << exception.backtrace.join("\n") if exception.backtrace
      str << '</box>'
      Style.apply(str)
    end
  end
end
