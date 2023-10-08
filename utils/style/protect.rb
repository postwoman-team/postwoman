module Style
  module_function

  def protect(obj)
    obj.to_s.gsub(Regexp.union(ESCAPE_CHARACTERS.keys), ESCAPE_CHARACTERS)
  end
end
