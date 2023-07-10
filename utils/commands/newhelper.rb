module Commands
  class Newhelper < Base
    ALIASES = %w[nh eh edithelper]
    DESCRIPTION = "Creates new loader helper, unless it already exists. Also opens the loader helper on you default editor."
    ARGS = [
      ['name', 'Loaders helper name in snake case.']
    ]

    def execute
      name = args[0]
      template = File.read('templates/loader_helper.rb')
      new_or_edit(name, 'loaders/utils/', template, 'helper')
    end
  end
end
