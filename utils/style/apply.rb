module Style
  module_function

  def apply(string)
    styled = string.gsub(Regexp.union(ESCAPE_CHARACTERS.values), ESCAPE_CHARACTERS.invert)

    tags = Env.config.dig(:theme, :tags)

    replace = {}
    tags.each do |tag, values|
      replace["<#{tag}>"] = values.first
      replace["</#{tag}>"] = values[1] if values[1]
    end

    styled.gsub!(%r{<box>(.*?)</box>}im) do
      table([[apply(::Regexp.last_match(1))]], protect: false)
    end

    styled.gsub(Regexp.union(replace.keys), replace)
  end
end
