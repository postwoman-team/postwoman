module Commands
  class Newhelper < Base
    def execute
      name = args[0]
      template = File.read('templates/loader_helper.rb')
      new_or_edit(name, 'loaders/utils/', template, 'helper')
    end
  end
end
