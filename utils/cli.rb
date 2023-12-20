module Cli
  module_function

  def start
    StartUp.execute

    while (line = Readline.readline('> ', true))
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
