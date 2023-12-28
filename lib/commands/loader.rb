module Commands
  class Loader < Base
    ALIASES = %w[ldr l].freeze
    DESCRIPTION = 'Creates new loader, unless it already exists. Also opens the loader on you default editor.'.freeze
    ARGS = {
      name: 'Loaders name in snake case. The terms must be divided by underscore(_), and must not start with a number.'
    }.freeze

    def execute
      name = positional_arg(0)&.downcase || return
      return puts Views::Commands::New.invalid_loader_name(name) unless is_loader_name?(name)

      template = File.read(Env.src_dir('templates/loader.rb'))
      template.gsub!('DoNotChangeThisClassName', camelize(name))

      Editor.create_and_open("loaders/#{name}.rb", template, 'loader')
    end
  end
end
