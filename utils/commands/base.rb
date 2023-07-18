module Commands
  class Base
    ALIASES = [].freeze
    DESCRIPTION = ''.freeze
    ARGS = {}.freeze

    attr_reader :args

    def initialize(args)
      @args = args
    end

    def execute; end

    def self.help_rows
      command_name = name.split('::')[1].upcase
      [
        ["#{command_name.green} (#{self::ALIASES.join(', ')})".green],
        ["- #{command_name.downcase} #{self::ARGS.map { |name, _| "<#{name}>" }.join(' ')}".gray],
        *args_rows,
        [self::DESCRIPTION]
      ]
    end

    def self.args_rows
      return [] if self::ARGS.empty?

      self::ARGS.map do |name, description|
        ["#{name.to_s.yellow} > #{description}"]
      end
    end

    private

    def display_request(request)
      print_payload(request.payload) unless args.flag?(:no_loader_payload)

      when_not_hidden('Headers'.purple, args.flag?(:no_headers)) do
        print_table(
          *request.headers.to_a
        )
      end

      when_not_hidden("#{'Body'.purple} - #{request.content_type.yellow}", args.flag?(:no_body)) do
        print_table(request.pretty_body)
      end

      print_table("Status: #{request.pretty_status}", "#{request.url}")
      binding.pry if args.flag?(:activate_binding_pry)
    end

    def print_payload(payload)
      print_table('Loader Arguments'.purple)
      print_table(JSON.pretty_generate(payload))
    end

    def print_workbench
      return print_table('Currently empty') if Env.workbench.empty?

      print_hash(Env.workbench)
    end

    def workbench
      Env.workbench
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

    def when_not_hidden(title, hide_flag)
      if hide_flag
        print_table("#{title} (Hidden)".gray)
        return
      end

      print_table(title)
      yield
    end

    def print_table(*rows)
      rows = [rows] if rows.first.instance_of?(String)
      rows = linebreak_rows(rows)
      table = Terminal::Table.new do |t|
        rows.each { |row| t << row }
        t.style = { border: :unicode }
      end
      puts table
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
          linebroken[1..].each do |line|
            new_rows << ['', line]
          end
        end
      end
      new_rows
    end

    def edit_loader(name)
      system("#{ENV['EDITOR']} loaders/#{name}.rb")
    end

    def edit_helper(name)
      system("#{ENV['EDITOR']} loaders/utils/#{name}.rb")
    end

    def new_or_edit(file_name, path, default_content, label)
      path = "#{path}#{file_name}.rb"

      if File.exist?(path)
        puts("Editing #{label}")
      else
        puts("Creating #{'new'.green} #{label}")
        File.open(path, 'w') do |f|
          f.write(default_content)
        end
      end

      open_in_editor(path)
    end

    def open_in_editor(path)
      return puts "Could not open loader because default editor isn't set.".yellow if ENV['EDITOR'].nil?

      system("#{ENV['EDITOR']} #{path}")
    end

    def obrigatory_positional_arg(index)
      value = args[index]
      positional_names = self.class::ARGS.keys
      return puts("Missing ##{index + 1} positional argument: #{positional_names[index]}".red) unless value

      value
    end
  end
end
