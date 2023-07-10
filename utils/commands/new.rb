module Commands
  class New < Base
    def execute
      name = args[0]
      path = "loaders/#{name}.rb"

      template = File.read('templates/loader.rb')
      template.gsub!('DoNotChangeThisClassName', camelize(name))

      new_or_edit(name, 'loaders/', template, 'loader')
    end
  end
end
