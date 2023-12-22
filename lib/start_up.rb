module StartUp
  module_function

  def execute
    Faraday.default_adapter = :typhoeus

    Readline.completion_append_character = ' '
    Readline.completion_proc = Autocompletion.generate_proc

    history = File.open('.postwoman_history', 'a+').readlines.map(&:chomp)
    Readline::HISTORY.push(*history)

    puts Views.start_up_message
  end
end
