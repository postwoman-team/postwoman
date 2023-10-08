module Style
  module_function

  def table(rows, protect: true)
    config = Env.config.dig('theme', 'tables')
    padding_amount = config['padding']
    padding = ' ' * padding_amount

    # split \n and normalize rows

    newline_treated_rows = []

    rows.each do |row|
      max_size = 0
      split_row = row.map do |cell|
        split_cells = cell.split("\n")
        max_size = split_cells.length if split_cells.length > max_size
        split_cells
      end.map do |split_cells|
        split_cells.concat([''] * (max_size - split_cells.length))
      end.transpose

      newline_treated_rows += split_row
    end

    rows = newline_treated_rows

    # set widths for each column to be printed, fitting terminal size

    columns = rows.transpose

    terminal_width = Readline.get_screen_size[1] - columns.length - 1
    current_column_widths = columns.map { |column| column.map { |cell| cell.gsub(/\e\[([;\d]+)?m/, '').length }.max }

    actual_column_widths = current_column_widths
    if current_column_widths.sum > terminal_width
      even_width_per_column = terminal_width/columns.length
      width_for_linebroken = terminal_width - actual_column_widths.select { |n| n < even_width_per_column }.sum

      actual_column_widths = current_column_widths.map do |width|
        width > even_width_per_column ? even_width_per_column : width
      end
    end

    # write the top of the table

    table = ''
    table << config.dig('corners', 'top_right')
    table << actual_column_widths.map do |width|
      str = ''
      str << config.dig('straight', 'horizontal') * width
      str << config.dig('straight', 'horizontal') * (padding_amount * (columns.length - 1))
    end.join(config.dig('junctions', 'top'))

    table << config.dig('corners', 'top_left')
    table << "\n"

    # write the contents of the table(breaks lines if needed)

    rows.each do |row|
      stripped_columns = row.map.with_index do |cell, column_i|
        width = actual_column_widths[column_i]
        cell.chars.each.with_index { |a|  }
        no_ansi = cell.gsub(/\e\[([;\d]+)?m/, '')


        cell.scan(/.{1,#{width}}/).map do |new_cell|
          new_cell.ljust(width)
        end
      end

      height = stripped_columns.map(&:length).max
      height += 1 if height > 1 && config['space_linebroken']
      new_columns = stripped_columns.map.with_index do |column, column_i|
        width = actual_column_widths[column_i]
        column.fill(' ' * width, column.length..(height - 1))
        column
      end

      table << new_columns.transpose.map do |row|
        str = ''
        str << config.dig('straight', 'vertical') + padding
        str << row.join(padding + config.dig('straight', 'vertical') + padding)
        str << padding + config.dig('straight', 'vertical')
      end.join("\n")
      table << "\n"
    end

    # writes the bottom of the table

    table << config.dig('corners', 'bottom_right')
    table << actual_column_widths.map do |width|
      str = ''
      str << config.dig('straight', 'horizontal') * width
      str << config.dig('straight', 'horizontal') * (padding_amount * (columns.length - 1))
    end.join(config.dig('junctions', 'bottom'))
    table << config.dig('corners', 'bottom_left')
    table << "\n"

    # protects the table if needed

    protect ? Style.protect(table) : table
  end
end
