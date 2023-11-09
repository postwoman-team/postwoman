module Commands
  class New < Base
    ALIASES = %w[n e edit].freeze
    DESCRIPTION = 'Creates new loader, unless it already exists. Also opens the loader on you default editor.'.freeze
    ARGS = {
      name: 'Loaders name in snake case. The terms must be divided by underscore(_), and must not start with a number.'
    }.freeze

    def execute
      name = obrigatory_positional_arg(0)&.downcase || return
      return puts Views::Commands::New.invalid_loader_name(name) unless is_loader_name?(name)

      path = "loaders/#{name}.rb"

      template = File.read('templates/loader.rb')
      template.gsub!('DoNotChangeThisClassName', camelize(name))

      new_or_edit(name, 'loaders/', template, 'loader')
    end
  end
end
