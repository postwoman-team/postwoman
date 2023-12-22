module Views
  module_function

  def invalid_package(path)
    Style.apply("<fail>Invalid directory: #{path}</fail><br>Type `postwoman -n my_path` to create a package or `postwoman my_path` to interact with a package")
  end
end
