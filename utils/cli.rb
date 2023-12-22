module Cli
  module_function

  def start
    path = ARGV.find { |arg| !arg.start_with?('-') } || '.'
    Package.create(path) if ARGV.include?('-n')
    return puts Views.invalid_package(path) unless Package.valid?(path)

    Dir.chdir(path)
    StartUp.execute

    while (line = Readline.readline("#{Package.metainfo(:name)}> ", true))
      if Readline::HISTORY.to_a.empty?
        File.write('.postwoman_history', "#{line}\n", mode: 'a')
      elsif Readline::HISTORY.to_a[-2] == line || /^\s*$/ =~ line
        Readline::HISTORY.pop
      else
        File.write('.postwoman_history', "#{line}\n", mode: 'a')
      end

      DynamicDependencies.load_loaders
      attempt_command(line)
    end
  end
end
