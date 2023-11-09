module Style
  module_function

  def table(rows, protect: true)
    options = Env.config.dig(:theme, :tables)
    table = Tabelinha.table(rows, **options, max_width: Readline.get_screen_size[1] - rows.first.length - 1)
    protect ? Style.protect(table) : table
  end
end
