module Commands
  class New < Base
    ALIASES = %w[n e edit]
    DESCRIPTION = "Creates new loader, unless it already exists. Also opens the loader on you default editor."
    ARGS = [
      ['name', 'Loaders name in snake case.']
    ]

    def execute
      name = args[0]
      path = "loaders/#{name}.rb"

      template = File.read('templates/loader.rb')
      template.gsub!('DoNotChangeThisClassName', camelize(name))

      new_or_edit(name, 'loaders/', template, 'loader')
    end
  end
end
