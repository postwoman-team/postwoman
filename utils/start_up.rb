module StartUp
  module_function

  def execute
    Readline.completion_append_character = ' '
    Readline.completion_proc = Autocompletion.generate_proc

    history = File.open('.postwoman_history', 'a+').readlines.map(&:chomp)
    Readline::HISTORY.push(*history)

    I18n.locale = Env.config[:language]

    puts Views.start_up_message
  end
end
