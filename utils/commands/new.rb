module Commands
  class New < Base
    ALIASES = %w[n e edit].freeze
    DESCRIPTION = "Creates new loader, unless it already exists. Also opens the loader on you default editor.".freeze
    ARGS = {
      name: 'Loaders name in snake case.'
    }.freeze

    def execute
      name = obrigatory_positional_arg(0) || return
      path = "loaders/#{name}.rb"

      template = File.read('templates/loader.rb')
      template.gsub!('DoNotChangeThisClassName', camelize(name))

      new_or_edit(name, 'loaders/', template, 'loader')
    end
  end
end
