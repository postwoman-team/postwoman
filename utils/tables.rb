def print_table(*rows)
  rows = [rows] if rows.first.instance_of?(String)
  rows = linebreak_rows(rows)
  table = Terminal::Table.new do |t|
    rows.each { |row| t << row }
    t.style = { border: :unicode }
  end
  puts table
end

def print_payload(payload)
  print_table('Loader Arguments'.purple)
  print_table(JSON.pretty_generate(payload))
end

def print_workbench
  return print_table('Currently empty') if Env.workbench.empty?

  print_hash(Env.workbench)
end

def print_hash(hash)
  print_table(
    *hash.to_a.map do |(k, v)|
      case v
      when NilClass
        v = 'null'
      when String
        v = "\"#{v.to_s.yellow}\""
      end
      [k, v]
    end
  )
end

def linebreak_rows(rows)
  break_at = 90
  new_rows = []
  rows.each do |row|
    linebroken = row.last.to_s.scan(/.{1,#{break_at}}/)
    if row.length == 1
      new_rows += linebroken.map { |line| [line] }
    else
      new_rows << [row.first, linebroken.first]
      linebroken[1..]&.each do |line|
        new_rows << ['', line]
      end
    end
  end
  new_rows
end
