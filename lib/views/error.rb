module Views
  module Error
    module_function

    def show(exception)
      str =  '<box><h2>'
      str << exception.class.name
      str << '</h2></box>'
      str << '<box>'
      str << '<fail>'
      str << exception.message
      str << '</fail>'
      str << ' <br> <br>'
      if exception.backtrace
        str << (minimal_backtrace ? exception.backtrace[0] : exception.backtrace.join("\n"))
      end
      str << '</box>'
      Style.apply(str)
    end
  end
end
