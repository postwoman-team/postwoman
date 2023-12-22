module Cli
  module_function

  def start
    path = ARGV.find { |arg| !arg.start_with?('-') } || '.'
    return unless Package.load(path, create_flag: ARGV.include?('-n'))

    StartUp.execute

    pre_input = '<preinput>'
    pre_input << Package.metainfo(:name)
    pre_input << '</preinput><pointer>'

    while (line = Readline.readline(Style.apply(pre_input), true))
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
