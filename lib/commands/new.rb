module Commands
  class New < Base
    ALIASES = %w[n e edit].freeze
    DESCRIPTION = 'Creates new file, unless it already exists. Also opens the file on you default editor.'.freeze
    ARGS = {
      category: "Category of the file. 's' for script, 'l' for loader",
      name: 'File name in snake case. The terms must be divided by underscore(_), and must not start with a number.'
    }.freeze

    def execute
      category_char = obrigatory_positional_arg(0)&.downcase || return
      name = obrigatory_positional_arg(1)&.downcase || return

      return puts Views::Commands::New.invalid_loader_name(name) unless is_loader_name?(name)

      case category_char
      when 'l'
        template = File.read(Env.src_dir('templates/loader.rb'))
        template.gsub!('DoNotChangeThisClassName', camelize(name))

        Editor.create_and_open("loaders/#{name}.rb", template, 'loader')
      when 's'
        FileUtils.mkdir_p('scripts')
        Editor.create_and_open("scripts/#{name}.rb", '', 'script')
      else
        puts Views::Commands::New.invalid_category(name)
      end
    end
  end
end
