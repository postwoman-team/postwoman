module Cli
  module_function

  def start # rubocop:disable Metrics/MethodLength,Metrics/PerceivedComplexity
    if ARGV.empty?
      Package.load_sandbox
    else
      return unless Package.load(
        ARGV.find { |arg| !arg.start_with?('-') } || '.',
        create_flag: ARGV.include?('-n')
      )
    end

    StartUp.execute

    pre_input = '<preinput>'
    pre_input << Package.metainfo(:name)
    pre_input << '</preinput><pointer>'

    while (line = Readline.readline(Style.apply(pre_input), true))
      DynamicDependencies.load_loaders

      if Readline::HISTORY.to_a.empty?
        File.write('.postwoman_history', "#{line}\n", mode: 'a')
      elsif Readline::HISTORY.to_a[-2] == line || /^\s*$/ =~ line
        Readline::HISTORY.pop
      else
        File.write('.postwoman_history', "#{line}\n", mode: 'a')
      end

      attempt_command(line)
    end
  end
end
