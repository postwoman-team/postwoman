module Style
  ESCAPE_CHARACTERS = {
    '&' => '&&',
    '<' => '&'
  }.freeze

  module_function

  def apply(string)
    tags = Env.config.dig(:theme, :tags)
    replace = {}
    tags.each do |tag, values|
      replace["<#{tag}>"] = values.first
      replace["</#{tag}>"] = values[1] if values[1]
    end

    styled = string.gsub(Regexp.union(replace.keys), replace)

    styled.gsub!(Regexp.union(ESCAPE_CHARACTERS.values), ESCAPE_CHARACTERS.invert)

    styled.gsub(%r{<box>(.*?)</box>}im) do
      table([[::Regexp.last_match(1)]], protect: false)
    end
  end

  def protect(obj)
    obj.to_s.gsub(Regexp.union(ESCAPE_CHARACTERS.keys), ESCAPE_CHARACTERS)
  end

  def table(rows, protect: true)
    options = Env.config.dig(:theme, :tables)
    table = Tabelinha.table(rows, **options, max_width: Readline.get_screen_size[1] - rows.first.length - 1)
    protect ? Style.protect(table) : table
  end
end
